//
//  ParknavMBNavigationRouter.swift
//  ParknavSDK
//

import UIKit

@objc protocol ParknavMBNavigationRoutingLogic {
    func closeNavigation()
    func pauseNavigation()
}

protocol ParknavMBNavigationDataPassing {
    var dataStore: ParknavMBNavigationDataStore? { get }
}

class ParknavMBNavigationRouter: NSObject, ParknavMBNavigationRoutingLogic, ParknavMBNavigationDataPassing {
    weak var viewController: ParknavMBNavigationViewController?
    weak var dataStore: ParknavMBNavigationDataStore?

    // MARK: Routing

    func closeNavigation() {
        viewController?.parentVC?.displayExitNavigation(viewModel: ParknavNavigation.Exit
                                                            .ViewModel(navigationObject: dataStore?.navigationExitObject,
                                                                       isPaused: false))
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParent()
    }

    func pauseNavigation() {
        viewController?.parentVC?.displayExitNavigation(viewModel: ParknavNavigation.Exit
                                                            .ViewModel(navigationObject: dataStore?.navigationExitObject,
                                                                       isPaused: true))
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParent()
    }
}
