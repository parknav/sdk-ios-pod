//
//  ParknavMBNavigationInteractor.swift
//  ParknavSDK
//

import UIKit
import CoreLocation
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import Mapbox
import AVFoundation

protocol ParknavMBNavigationBusinessLogic {
    var route: Route? { get set }
    var directions: Directions { get set }
    var delegate: ParknavEventsListener? { get set }
    var locationHistoryService: LocationHistoryService? { get set }
    var parknavRouteOptions: ParknavRouteOptions { get set }

    func subscribeForNotifications()
    func unsubscribeFromNotifications()
    func prepareToExitNavigation(_ currentLocation: CLLocation?)
    func checkParkingInstructions(_ waipointsCount: Int?)
    func prepareGarages(_ mapView: MGLMapView?)
}

protocol ParknavMBNavigationDataStore: AnyObject {
    var navigationExitObject: ParknavNavigationObject? {get set}
}

class ParknavMBNavigationInteractor: ParknavMBNavigationDataStore {

    // MARK: - Internal properties

    var presenter: ParknavMBNavigationPresentationLogic?
    lazy var worker: ParknavNavigationWorker? = ParknavNavigationWorker()
    lazy var routeLayersWorker: ParknavRouteLayersWorker? = ParknavRouteLayersWorker()
    var navigationExitObject: ParknavNavigationObject?

    var waypoints = [Waypoint]()

    private var lastRerouteLocation: CLLocation?

    // MARK: - ParknavMBNavigationBusinessLogic properties

    var route: Route?
    weak var delegate: ParknavEventsListener?

    lazy var directions = Directions(accessToken: ParknavConstans.API.mapboxAccessToken)
    lazy var locationHistoryService: LocationHistoryService? =
        LocationHistoryService(parknavOptions: ParknavRouteOptions.instance) {
        didSet { if lastRerouteLocation == nil { lastRerouteLocation = locationHistoryService?.lastDetectedLocation } } }

    var parknavRouteOptions: ParknavRouteOptions = ParknavRouteOptions.instance

    // MARK: Object lifecycle

    deinit {
        worker = nil
        locationHistoryService = nil
        routeLayersWorker = nil
    }

    // MARK: - Private functions

    @objc func locationChanged(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let location = userInfo[RouteControllerNotificationUserInfoKey.locationKey] as? CLLocation,
              location.isActualLocation else {return}
        addChangedLocation(location)
    }

    private func addChangedLocation(_ newLocation: CLLocation?) {
        guard let location = newLocation, location.isActualLocation else {return}
        locationHistoryService?.addLocation(location)
    }

    private func prepareLocationToDisplay() {
        print("ParknavMBNavigationInteractor: prepareLocationToDisplay")
        if let userLocation = locationHistoryService?.lastDetectedLocation, userLocation.isActualLocation {
            prepareDirections()
        } else {
            presenter?.presentError(response: ParknavNavigation.Error.Response(error: ParknavConstans.Errors.locationNotDetected))
        }
    }

    private func prepareDirections() {
        guard let location = locationHistoryService?.lastDetectedLocation?.coordinate else {return}
//        worker = ParknavNavigationWorker()
        worker?.getRoute(location, currentAngle: locationHistoryService?.currentAngle ?? 0, options: parknavRouteOptions)
            .onSuccess { [weak self] response in
                self?.parknavRouteOptions.previousRequestId = response.uuid
                self?.route = response.routes.first
                self?.route?.accessToken = ParknavConstans.API.mapboxAccessToken
                self?.waypoints = response.waypoints
                self?.locationHistoryService?.lastResponseBaseURL = response.baseURL
                self?.startNavigation()
            }.onFailure { [weak self] _ in
                self?.route = nil
                self?.waypoints.removeAll()
//                self.presenter?.presentError(response: ParknavNavigation.Error.Response(error: error))
        }
    }

    private func startNavigation() {
        print("ParknavMBNavigationInteractor: startNavigation")
        var response = ParknavNavigation.State.Response()
        response.waypointsCount = waypoints.count
        presenter?.presentNavigation(response: response)
        if waypoints.count <= 2 {
            presenter?.presentParkingInstruction(waypointsCount: waypoints.count)
        }
    }

    private func sendEndNavigationEvent(_ isParked: Bool, location: CLLocationCoordinate2D? = nil) {
        print("ParknavMBNavigationInteractor: sendEndNavigationEvent")
        let endLocation = location ?? locationHistoryService?.lastDetectedLocation?.coordinate
        print("End navigation: \(String(describing: endLocation)), isParked: \(isParked)")
        worker = ParknavNavigationWorker()
        worker?.sendEndNavigation(isParked: isParked, endLocation: endLocation)
    }

    @objc func applicationWillTerminate() { sendEndNavigationEvent(false) }
}

// MARK: - ParknavMBNavigationBusinessLogic

extension ParknavMBNavigationInteractor: ParknavMBNavigationBusinessLogic {
    func subscribeForNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(locationChanged(_:)),
                                               name: .routeControllerProgressDidChange,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillTerminate),
                                               name: UIApplication.willTerminateNotification,
                                               object: nil)
    }

    func unsubscribeFromNotifications() { NotificationCenter.default.removeObserver(self) }

    func prepareToExitNavigation(_ currentLocation: CLLocation?) {
        print("ParknavMBNavigationInteractor: prepareToExitNavigation")
        navigationExitObject = ParknavNavigationObject(exitType: .normal, lastUserLocation: currentLocation)
        sendEndNavigationEvent(true, location: currentLocation?.coordinate)
        presenter?.presentExitNavigation(response: ParknavNavigation.Exit.Response(navigationObject: nil))
    }

    func checkParkingInstructions(_ waipointsCount: Int?) {
        let waipointsCount = waipointsCount ?? route?.routeOptions.waypoints.count ?? 0
        if waipointsCount == 2, locationHistoryService?.lastResponseBaseURL == ParknavConstans.API.parknavBaseURL {
            presenter?.presentParkingInstruction(waypointsCount: waipointsCount)
        }
    }

    func prepareGarages(_ mapView: MGLMapView?) {
        guard let mapView = mapView else {return}
        let routeValue = route?.routeMessage?.value ?? 0
        guard (parknavRouteOptions.garageSupport == .garagesFromStart) ||
                (parknavRouteOptions.garageSupport == .garagesWhenNoParking
                    && routeValue <= ParknavConstans.Location.minRouteScoreForParking) else { return }
        ParknavServiceHelper.instance.serverInfo = parknavRouteOptions.serverInfo
        var layerRules = LayerRules()
        layerRules.destination = parknavRouteOptions.destination ?? locationHistoryService?.lastDetectedLocation?.coordinate
        layerRules.enabledLayers = [LayerType.garages]
        ParknavLayersService.showLayers(map: mapView, layerRules: layerRules)
    }
}

// MARK: - NavigationViewControllerDelegate

extension ParknavMBNavigationInteractor: NavigationViewControllerDelegate {
    func navigationViewController(_ navigationViewController: NavigationViewController, shapeFor routes: [Route]) -> MGLShape? {
        if routes.count > 1 { print("Routes count > 1") }
        guard let firstRoute = routes.first else {return nil}
        var routesLegs: [MGLPolylineFeature] = []
        for index in firstRoute.legs.indices {
            routesLegs += routeLayersWorker?.addCongestion(to: firstRoute, legIndex: index) ?? [] }
        return MGLShapeCollectionFeature(shapes: routesLegs)
    }

    func navigationViewControllerDidDismiss(_ navigationViewController: NavigationViewController, byCanceling canceled: Bool) {
        print("ParknavMBNavigationInteractor: By cancelling: \(canceled)")
        navigationExitObject =
            ParknavNavigationObject(exitType: .normal,
                                    lastUserLocation: navigationViewController.navigationService.locationManager.location)
        sendEndNavigationEvent(false, location: navigationViewController.navigationService.locationManager.location?.coordinate)
        presenter?.presentPauseNavigation()
    }

    func navigationViewController(_ navigationViewController: NavigationViewController,
                                  shouldRerouteFrom location: CLLocation) -> Bool {
        print("ParknavMBNavigationInteractor: shouldRerouteFrom")

        if let lastRerouteLocation = lastRerouteLocation,
           lastRerouteLocation.distance(from: location) < ParknavConstans.Location.minDistanceBeforeRerouting {
            return false }
        lastRerouteLocation = location
        if delegate?.shouldReroute(from: location) ?? true {
            addChangedLocation(location)
            prepareLocationToDisplay()
        }
        return false
//        return navigationViewController.navigationService.router.userIsOnRoute(location)
    }

    func navigationViewController(_ navigationViewController: NavigationViewController, didRerouteAlong route: Route) {
        delegate?.didChangeRoute(route)
    }

    func navigationViewController(_ navigationViewController: NavigationViewController,
                                  didArriveAt waypoint: Waypoint) -> Bool {
        // swiftlint:disable line_length
        print("ParknavMBNavigationInteractor: didArriveAt waypoint \(navigationViewController.navigationService.routeProgress.remainingWaypoints.count)")
        // swiftlint:enable line_length
        checkParkingInstructions(navigationViewController.navigationService.routeProgress.remainingWaypoints.count)

        let lastWaypoint = navigationViewController.navigationService.routeProgress.remainingWaypoints.last
        guard waypoint.coordinate == lastWaypoint?.coordinate,
              !(delegate?.didArriveToParking(waypoint) ?? false) else { return true }
        prepareLocationToDisplay()
        return false
    }

    func navigationViewController(_ navigationViewController: NavigationViewController,
                                  mapViewUserAnchorPoint mapView: NavigationMapView) -> CGPoint {
        let contentFrame = mapView.bounds.inset(by: mapView.contentInset)
        let courseViewWidth = mapView.userCourseView?.frame.width ?? 0
        let courseViewHeight = mapView.userCourseView?.frame.height ?? 0
        let edgePadding = UIEdgeInsets(top: 50 + courseViewHeight / 2,
                                       left: 50 + courseViewWidth / 2,
                                       bottom: 50 + courseViewHeight / 2,
                                       right: 50 + courseViewWidth / 2)
        return CGPoint(x: max(min(contentFrame.midX,
                                  contentFrame.maxX - edgePadding.right),
                              contentFrame.minX + edgePadding.left),
                       y: max(max(min(contentFrame.minY + contentFrame.height * 0.8,
                                      contentFrame.maxY - edgePadding.bottom),
                                  contentFrame.minY + edgePadding.top),
                              contentFrame.minY + contentFrame.height * 0.5) - ParknavConstans.UI.bottomBannerViewHeight)
    }
}

extension ParknavMBNavigationInteractor: VoiceControllerDelegate {
    func voiceController(_ voiceController: RouteVoiceController, spokenInstructionsDidFailWith error: Error) {
        print("ParknavMBNavigationInteractor: VoiceController: spokenInstructionsDidFail!!!!")
    }

    func voiceController(_ voiceController: RouteVoiceController, didInterrupt interruptedInstruction: SpokenInstruction,
                         with interruptingInstruction: SpokenInstruction) {
        print("ParknavMBNavigationInteractor: VoiceController: didInterrupt")
    }

    func voiceController(_ voiceController: RouteVoiceController, willSpeak instruction: SpokenInstruction,
                         routeProgress: RouteProgress) -> SpokenInstruction? {
        print("ParknavMBNavigationInteractor: VoiceController: willSpeak")
        return instruction
    }
}
