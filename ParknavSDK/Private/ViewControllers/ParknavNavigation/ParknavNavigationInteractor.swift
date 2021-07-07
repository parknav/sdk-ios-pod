//
//  ParknavNavigationInteractor.swift
//  ParknavSDK
//

import UIKit
import CoreLocation
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import Mapbox
// 30,225524 -97,777232
protocol ParknavNavigationBusinessLogic: AnyObject {
    var route: Route? { get set }
    var directions: Directions { get set }
    var delegate: ParknavEventsListener? { get set}
    var isRouting: Bool {get set}
    var locationHistoryService: LocationHistoryService { get set }
    var parknavRouteOptions: ParknavRouteOptions { get set }

    var navigationObject: ParknavNavigationObject? { get set }

    func startDetectLocation()
    func stopNavigation()
    func checkLocationAccess()
    func prepareToCloseNavigation()
}

protocol ParknavNavigationDataStore {
    var navigationObject: ParknavNavigationObject? { get set }

    func addChangedLocation(_ newLocation: CLLocation?)
    func prepareLocationToDisplay()
}

class ParknavNavigationInteractor: NSObject, ParknavNavigationDataStore {
    var presenter: ParknavNavigationPresentationLogic?
    lazy var worker: ParknavNavigationWorker? = ParknavNavigationWorker()
    lazy var routeLayersWorker: ParknavRouteLayersWorker? = ParknavRouteLayersWorker()

    var route: Route?
    var routeGeometry: String?
    var directions: Directions = Directions(accessToken: ParknavConstans.API.mapboxAccessToken)
    var isRouting = false
    weak var delegate: ParknavEventsListener?

    var waypoints = [Waypoint]()

    var locationHistoryService: LocationHistoryService
    var parknavRouteOptions: ParknavRouteOptions

    var navigationObject: ParknavNavigationObject?

    // MARK: - Private properties

    private let locationManager = CLLocationManager()
    private weak var timer: Timer?

    // MARK: - Object lifecycle

    init(parknavRouteOptions: ParknavRouteOptions) {
        self.locationHistoryService = LocationHistoryService(parknavOptions: parknavRouteOptions)
        self.parknavRouteOptions = parknavRouteOptions
        super.init()
        setupMapboxAccess()
    }

    deinit {
        presenter = nil
        worker = nil
        routeLayersWorker = nil
    }

    // MARK: - Private functions

    private func setupMapboxAccess() { MGLAccountManager.accessToken = ParknavConstans.API.mapboxAccessToken }

    private func startNavigation() {
//        guard route != nil else { prepareToStopNavigation(nil); return }
//        self.timer?.invalidate()
//        self.timer = nil
        var response = ParknavNavigation.State.Response()
        response.waypoints = waypoints
        response.waypointsCount = waypoints.count
        response.route = route
        self.presenter?.presentNavigation(response: response)
//        isRouting = true
    }

    private func prepareDirections(_ currentCoordinate: CLLocationCoordinate2D) {
        guard !isRouting else { return }
        worker?.getRoute(currentCoordinate, currentAngle: locationHistoryService.currentAngle, options: parknavRouteOptions)
            .onSuccess { [weak self] response in
                self?.parknavRouteOptions.previousRequestId = response.uuid
                self?.route = response.routes.first
                self?.route?.accessToken = ParknavConstans.API.mapboxAccessToken
                self?.waypoints = response.waypoints
                self?.locationHistoryService.lastResponseBaseURL = response.baseURL
                self?.routeGeometry = response.geometries.first
                self?.startNavigation()
            }.onFailure { [weak self] error in
                self?.route = nil
                self?.waypoints.removeAll()
                self?.prepareToStopNavigation(error)
        }
    }

    func addChangedLocation(_ newLocation: CLLocation?) {
        guard let location = newLocation, location.isActualLocation else {return}
        locationHistoryService.addLocation(location)
    }

    func prepareToStopNavigation(_ error: NSError?) {
//        if isRouting {
            isRouting = false
            stopNavigation()
//        }
//        guard let error = error else {return}
//        presenter?.presentError(response: ParknavNavigation.Error.Response(error: error))
    }
}

// MARK: - ParknavNavigationBusinessLogic

extension ParknavNavigationInteractor: ParknavNavigationBusinessLogic {
    func startDetectLocation() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: ParknavConstans.Location.maxDetectLocationTime, target: self,
                                     selector: #selector(locationNotDetected), userInfo: nil, repeats: false)
    }

    @objc func locationNotDetected() {
        timer?.invalidate()
        timer = nil
        prepareToStopNavigation(ParknavConstans.Errors.locationNotDetected)
    }

    @objc func prepareLocationToDisplay() {
        print("prepareLocationToDisplay")
        timer?.invalidate()
        timer = nil

        if let userLocation = locationHistoryService.lastDetectedLocation {
            print(userLocation.coordinate)
//        }, userLocation.isActualLocation {
            prepareDirections(userLocation.coordinate)
        } else {
            prepareToStopNavigation(ParknavConstans.Errors.locationNotDetected)
        }
    }

    func stopNavigation() {
        var response = ParknavNavigation.State.Response()
        response.waypointsCount = waypoints.count
        presenter?.presentNavigation(response: response)
    }

    func checkLocationAccess() {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        guard authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways else {
            presenter?.presentMapView()
            return
        }
        if authorizationStatus == .notDetermined {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        } else {
            presenter?.presentAppSettingsAlert()
        }
    }

    func prepareToCloseNavigation() {
        let navigationExitObject = navigationObject ??
            ParknavNavigationObject(exitType: .normal, lastUserLocation: locationHistoryService.lastDetectedLocation)
        presenter?.presentCloseNavigation(response: ParknavNavigation.Exit.Response(navigationObject: navigationExitObject))
    }
}

// MARK: - MGLMapViewDelegate

extension ParknavNavigationInteractor: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        guard let userLocation = userLocation, let location = userLocation.location, location.isActualLocation else {return}
        let previousLocation = locationHistoryService.lastDetectedLocation
        addChangedLocation(location)
        guard !location.isWithinAccuracyInterval(from: previousLocation) else {return}
        prepareLocationToDisplay()
    }

    func mapViewDidFailLoadingMap(_ mapView: MGLMapView, withError error: Error) {
        prepareToStopNavigation(error as NSError)
    }

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        print("Parknav: finish loading map")
        presenter?.presentCurrentLocation(response: ParknavNavigation.CurrentLocation
                                            .Response(location: ParknavConstans.Location.defaultLocation))
        style.localizeLabels(into: Locale(identifier: parknavRouteOptions.localeID))
        Locale.nationalizedCurrent = Locale(identifier: parknavRouteOptions.localeID)
    }
}

// MARK: - CLLocationManagerDelegate

extension ParknavNavigationInteractor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {return}
        locationManager.delegate = nil
        presenter?.presentMapView()
    }
}

// MARK: - NavigationMapViewDelegate

extension ParknavNavigationInteractor: NavigationMapViewDelegate {
    func navigationMapView(_ mapView: NavigationMapView, shapeFor routes: [Route]) -> MGLShape? {
        guard let firstRoute = routes.first else {return nil}
        var routesLegs: [MGLPolylineFeature] = []
        for index in firstRoute.legs.indices {
            routesLegs += routeLayersWorker?.addCongestion(to: firstRoute, legIndex: index) ?? [] }
        return MGLShapeCollectionFeature(shapes: routesLegs)
    }
}
