//
//  ParkingChanceRouter.swift
//  ParknavSDK

import UIKit
import CoreLocation

@objc protocol ParkingChanceRoutingLogic {
    func routeToNavigationController()
}

protocol ParkingChanceDataPassing {
    var dataStore: ParkingChanceDataStore? { get }
}

class ParkingChanceRouter: NSObject, ParkingChanceRoutingLogic, ParkingChanceDataPassing {
    weak var viewController: ParkingChanceViewController?
    weak var dataStore: ParkingChanceDataStore?

    // MARK: Routing

    func routeToNavigationController() {
        guard let viewController = self.viewController else {return}
        var parknavRouteOptions = dataStore?.parknavRouteOptions ?? ParknavRouteOptions.instance
        parknavRouteOptions.destination = dataStore?.layerRules.destination
        _ = ParknavNavigationViewController.presentFrom(viewController, options:
            parknavRouteOptions)
    }
}
