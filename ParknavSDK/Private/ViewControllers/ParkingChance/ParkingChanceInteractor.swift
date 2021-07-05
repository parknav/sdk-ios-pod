//
//  ParkingChanceInteractor.swift
//  ParknavSDK
//

import UIKit
import Mapbox

protocol ParkingChanceBusinessLogic {
    var mapView: MGLMapView? { get set }
    func prepareToRecenterMap(_ onDestination: Bool)
    func prepareToClose()
}

protocol ParkingChanceDataStore: AnyObject {
    var layerRules: LayerRules { get set }
    var parknavRouteOptions: ParknavRouteOptions? { get set }
}

class ParkingChanceInteractor: NSObject, ParkingChanceDataStore {
    weak var presenter: ParkingChancePresentationLogic?
    weak var mapView: MGLMapView?
    var layerRules: LayerRules
    var parknavRouteOptions: ParknavRouteOptions?

    // MARK: - Private properties

    private var followUserMode = false
    private var isMapLoaded = false
    private var gotInitialLocation = false
    private var timer: Timer?
    private var reloadRadius = Double(ParknavConstans.Layers.radius)

    private var currentLocation: CLLocation? {
        didSet { layerRules.userLocation = currentLocation } }

    private var destination: CLLocationCoordinate2D? {
        didSet { layerRules.destination = destination } }

    // MARK: - Object lifecycle

    init(_ layerRules: LayerRules, parknavRouteOptions: ParknavRouteOptions?) {
        self.layerRules = layerRules
        self.parknavRouteOptions = parknavRouteOptions
        super.init()

        followUserMode = parknavRouteOptions?.destination == nil && parknavRouteOptions?.allowDestinationSelection == false
        if followUserMode { reloadRadius -= ParknavConstans.Layers.reloadMargin }
        setupMapboxAccess()
    }

    // MARK: - Private functions

    private func setupMapboxAccess() {
        MGLAccountManager.accessToken = ParknavConstans.API.mapboxAccessToken
    }

    private func restartTimer() {
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: layerRules.updateTime,
                                     target: self,
                                     selector: #selector(getLayers),
                                     userInfo: nil, repeats: false)
    }
}

// MARK: - ParkingChanceBusinessLogic

extension  ParkingChanceInteractor: ParkingChanceBusinessLogic {

    func prepareToRecenterMap(_ onDestination: Bool) {
        destination = onDestination ? destination : mapView?.userLocation?.coordinate
        guard let centerCoordinates = destination else {return}
        destination = centerCoordinates
        getLayers()
        presenter?.presentReceneteredMap(centerCoordinates)
    }

    func prepareToClose() {
        timer?.invalidate()
        timer = nil
        gotInitialLocation = false
    }

    @objc func getLayers() {
        defer { restartTimer() }
        guard isMapLoaded, let mapView = mapView else {return}
        currentLocation = mapView.userLocation?.location
        ParknavServiceHelper.instance.serverInfo = parknavRouteOptions?.serverInfo
        ParknavLayersService.showLayers(map: mapView, layerRules: layerRules)
    }
}

// MARK: - MGLMapViewDelegate

extension ParkingChanceInteractor: MGLMapViewDelegate {

    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        guard !gotInitialLocation else {
            if followUserMode, let nextDestination = userLocation?.coordinate,
            let prevDestination = destination,
            nextDestination.isFarFromDestination(prevDestination, threshold: ParknavConstans.Location.movementTolerance) {
                mapView.setCenter(nextDestination, animated: true)
                updateDestination(prevDestination: prevDestination, nextDestination: nextDestination)
            }
            return
        }
        destination = destination ?? userLocation?.coordinate
        getLayers()
        gotInitialLocation = true
    }

    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        guard !isMapLoaded else { return }
        isMapLoaded = true
        getLayers()
    }

    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
        guard reason == .gesturePan || reason == .gesturePinch || reason == .gestureRotate ||
                reason == .gestureZoomIn || reason == .gestureZoomOut || reason == .gestureOneFingerZoom ||
                reason == .gestureTilt else { return }
        if let prevDestination = destination,
           let nextDestination = followUserMode ? mapView.userLocation?.coordinate : mapView.centerCoordinate {
            updateDestination(prevDestination: prevDestination, nextDestination: nextDestination)
        }
    }

    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        guard let polyline = annotation as? MGLPolylineFeature,
            let probability = polyline.attribute(forKey: "prob") as? Double
            else { return mapView.tintColor }
        return probability.probailityColor
    }

    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        ParknavConstans.Layers.shapeAnnotationAlpha }

    private func updateDestination(prevDestination: CLLocationCoordinate2D, nextDestination: CLLocationCoordinate2D) {
        let distance = nextDestination.distance(from: prevDestination)
        guard distance >= reloadRadius else {return}
        destination = nextDestination
        getLayers()
    }
}
