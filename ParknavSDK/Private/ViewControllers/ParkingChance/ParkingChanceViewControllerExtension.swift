//
//  ParkingChanceViewControllerExtension.swift
//  ParknavSDK
//
//  Created by Ekaterina Kharlamova on 25/06/2021.
//  Copyright © 2021 AI Incube. All rights reserved.
//

import Foundation
import Mapbox

protocol ParkingChanceDisplayLogic: AnyObject {
    func displayRecenteredMap(_ coordinates: CLLocationCoordinate2D)
}

 // MARK: - Internal

extension ParkingChanceViewController {
    func deactivateMapView() {
        mapView?.setUserTrackingMode(.none, animated: false, completionHandler: nil)
        mapView?.showsUserLocation = false
//        mapView?.delegate = nil
        mapView?.removeFromSuperview()
        mapView = nil
    }

    func configureMapView() {
        guard mapView == nil else {return}
        mapView = MGLMapView(frame: view.bounds)
        mapView.delegate = interactor as? MGLMapViewDelegate
        interactor?.mapView = mapView
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setUserTrackingMode(.followWithHeading, animated: true, completionHandler: nil)
        mapView.showsUserLocation = true
        view.insertSubview(mapView, at: 1)
        print("Parknav: userLocation: \(String(describing: mapView.userLocation))")
    }

    func setup(_ layerRules: LayerRules?, options: ParknavRouteOptions?) {
        let layerRules = layerRules ?? LayerRules.instance
        interactor = ParkingChanceInteractor(layerRules, parknavRouteOptions: options)
        let presenter = ParkingChancePresenter()
        (interactor as? ParkingChanceInteractor)?.presenter = presenter
        presenter.viewController = self
        (router as? ParkingChanceRouter)?.viewController = self
        (router as? ParkingChanceRouter)?.dataStore = interactor as? ParkingChanceDataStore
    }
}

// MARK: - ParkingChanceDisplayLogic

extension ParkingChanceViewController: ParkingChanceDisplayLogic {

    func displayRecenteredMap(_ coordinates: CLLocationCoordinate2D) {
        mapView.setCenter(coordinates, zoomLevel: 14, animated: false)
    }
}

// MARK: - ParkingMenuViewDelegate

extension ParkingChanceViewController: ParkingMenuViewDelegate {

    func didTouchNavigationButton() {
        print("didTouchNavigationButton")
        router?.routeToNavigationController()
    }
}
