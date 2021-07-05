//
//  ParknavNavigationRouter.swift
//  ParknavSDK
//

import UIKit

@objc protocol ParknavNavigationRoutingLogic {
    func showAppSettings()
    func closeNavigation(completion: (() -> Void)?)
}

protocol ParknavNavigationDataPassing {
    var dataStore: ParknavNavigationDataStore? { get }
}

class ParknavNavigationRouter: NSObject, ParknavNavigationRoutingLogic, ParknavNavigationDataPassing {
    weak var viewController: ParknavNavigationViewController?
    var dataStore: ParknavNavigationDataStore?

    // MARK: - Routing

    func closeNavigation(completion: (() -> Void)?) {
        viewController?.dismiss(animated: true, completion: completion)
    }

    func showAppSettings() {
        viewController?.dismiss(animated: true, completion: nil)
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
}
