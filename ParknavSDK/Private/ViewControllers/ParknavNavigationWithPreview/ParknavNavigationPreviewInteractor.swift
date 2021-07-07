//
//  ParknavNavigationPreviewInteractor.swift
//  ParknavSDK
//
//

import UIKit
import Mapbox
import MapboxNavigation
import MapboxDirections

protocol ParknavNavigationPreviewBusinessLogic {
    var isInitialLoading: Bool {get set}
    func prepareToStartNavigation()
    func prepareArrivalValues()
    func prepareToRecenterMap(_ coordinates: CLLocationCoordinate2D?)
    func prepareGarages(_ mapView: MGLMapView?)
    func prepareToCloseGarageInfo()
    func prepareToStartNavigationToGarage()
    func processPauseNavigation(_ navigationObject: ParknavNavigationObject?)
}

class ParknavNavigationPreviewInteractor: ParknavNavigationInteractor {

    lazy var isInitialLoading: Bool = true
    var selectedGarage: MGLPointFeature?

    // MARK: - Private properties

    private var localPresenter: ParknavNavigationPreviewPresentationLogic? {
        presenter as? ParknavNavigationPreviewPresentationLogic }

    private func prepareGarageDirections(_ currentCoordinate: CLLocationCoordinate2D) {
        parknavRouteOptions.isNavigationOnly = true
        worker?.getRoute(currentCoordinate, currentAngle: locationHistoryService.currentAngle, options: parknavRouteOptions)
            .onSuccess { [weak self] response in
                self?.parknavRouteOptions.previousRequestId = response.uuid
                self?.startGarageNavigation(with: response.routes.first, waypoints: response.waypoints)
            }.onFailure { [weak self] error in
                self?.errorGarageNavigation(error)
        }
    }

    private func startGarageNavigation(with route: Route?, waypoints: [Waypoint]) {
        var response = ParknavNavigation.State.Response()
        response.waypointsCount = waypoints.count
        response.route = route
        response.waypoints = waypoints
        localPresenter?.presentNavigationController(response: response)
    }

    private func errorGarageNavigation(_ error: NSError) {}

    override func prepareToStopNavigation(_ error: NSError?) {
        super.stopNavigation()
        if parknavRouteOptions.garageSupport == .noGarages {
        } else { localPresenter?.presentGarages() }
    }

    // MARK: - ParknavNavigationBusinessLogic

    override func prepareLocationToDisplay() {
        if parknavRouteOptions.garageSupport == .garagesFromStart {
            localPresenter?.presentGarages() }
        if locationHistoryService.lastDetectedLocation?.coordinate
            .isFarFromDestination(parknavRouteOptions.destination,
                                  threshold: parknavRouteOptions.destinationReachedThreshold) ?? false {
            parknavRouteOptions.navigateToDestination = true }
        super.prepareLocationToDisplay()
    }

    // MARK: - MGLMapViewDelegate

    override func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        guard let userLocation = userLocation, let location = userLocation.location, location.isActualLocation else {return}
        let previousLocation = locationHistoryService.lastDetectedLocation
        addChangedLocation(location)
        guard !location.isWithinAccuracyInterval(from: previousLocation) else {return}
        prepareLocationToDisplay()
    }

    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
        guard parknavRouteOptions.allowDestinationSelection else {return}
        guard reason == .gesturePan || reason == .gesturePinch || reason == .gestureRotate ||
                reason == .gestureZoomIn || reason == .gestureZoomOut || reason == .gestureOneFingerZoom ||
                reason == .gestureTilt else { return }
        parknavRouteOptions.destination = mapView.centerCoordinate
        print("regionDidChange")
        prepareLocationToDisplay()
    }

    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        guard let garage = annotation as? MGLPointFeature else { return nil }
        return GaragesLayer.icon(garage)
    }

    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        guard let garage = annotation as? MGLPointFeature else {return}
        selectedGarage = garage
        localPresenter?.presentGarageInfo(response: ParknavNavigationPreview.Garage.Response(garage: garage))
    }
}

// MARK: - StyleManagerDelegate

extension ParknavNavigationPreviewInteractor: StyleManagerDelegate {
    func location(for styleManager: StyleManager) -> CLLocation? { locationHistoryService.lastDetectedLocation }

    func styleManager(_ styleManager: StyleManager, didApply style: Style) {
        localPresenter?.presentMapStyle(response: ParknavNavigationPreview.MapStyle.Response(style: style))
    }

    func styleManagerDidRefreshAppearance(_ styleManager: StyleManager) { localPresenter?.presentReloadedMapStyle() }
}

// MARK: - ParknavNavigationPreviewBusinessLogic

extension ParknavNavigationPreviewInteractor: ParknavNavigationPreviewBusinessLogic {

    func prepareToStartNavigation() {
        var response = ParknavNavigation.State.Response()
        response.waypointsCount = waypoints.count
        localPresenter?.presentNavigationController(response: response)
    }

    func prepareArrivalValues() {
        isInitialLoading = false
        guard let route = route else {return}
        localPresenter?.presentArrivalValues(response: ParknavNavigationPreview.Arrival.Response(
                                                expectedTime: route.expectedTravelTime, expectedDistance: route.distance))
    }

    func prepareToRecenterMap(_ coordinates: CLLocationCoordinate2D?) {
        guard let userCoordinates = coordinates else {return}
        parknavRouteOptions.destination = userCoordinates
        print("prepareToRecenterMap")
        prepareLocationToDisplay()
        localPresenter?.presentReceneteredMap(userCoordinates)
    }

    func prepareGarages(_ mapView: MGLMapView?) {
        guard let mapView = mapView else {return}
        let routeValue = route?.routeMessage?.value ?? 0
        guard (parknavRouteOptions.garagesOnParkingRoute) || (parknavRouteOptions.garageSupport == .garagesFromStart) ||
                (parknavRouteOptions.garageSupport == .garagesWhenNoParking &&
                    routeValue <= ParknavConstans.Location.minRouteScoreForParking) else { return }
        ParknavServiceHelper.instance.serverInfo = parknavRouteOptions.serverInfo
        var layerRules = LayerRules()
        layerRules.destination = parknavRouteOptions.destination ?? locationHistoryService.lastDetectedLocation?.coordinate
        layerRules.enabledLayers = [LayerType.garages]
        ParknavLayersService.showLayers(map: mapView, layerRules: layerRules) { [weak self] layer in
            guard let garagesLayer = layer as? GaragesLayer else {return layer}
            garagesLayer.radius = self?.parknavRouteOptions.garageRadius
            garagesLayer.garagesOnParkingRoute = self?.parknavRouteOptions.garagesOnParkingRoute ?? false
            if self?.parknavRouteOptions.garagesOnParkingRoute ?? false, let geometry = self?.routeGeometry {
                garagesLayer.routeGeometry = geometry
            }
            return layer
        }
    }

    func prepareToCloseGarageInfo() {
        selectedGarage = nil
        localPresenter?.presentCloseGarageInfo()
    }

    func prepareToStartNavigationToGarage() {
        guard let selectedGarage = self.selectedGarage,
              let userLocation = locationHistoryService.lastDetectedLocation else { return }
        parknavRouteOptions.destination = selectedGarage.coordinate
        prepareGarageDirections(userLocation.coordinate)
    }

    func processPauseNavigation(_ navigationObject: ParknavNavigationObject?) {
        self.navigationObject = navigationObject
        selectedGarage = nil
        parknavRouteOptions.isNavigationOnly = false
        isRouting = false
    }
}
