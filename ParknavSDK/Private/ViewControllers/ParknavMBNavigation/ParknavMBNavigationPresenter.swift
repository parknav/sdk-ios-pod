//
//  ParknavMBNavigationPresenter.swift
//  ParknavSDK
//

import UIKit

protocol ParknavMBNavigationPresentationLogic: ParknavPresentationLogic {
    func presentParkingInstruction(waypointsCount: Int)
    func presentExitNavigation(response: ParknavNavigation.Exit.Response)
    func presentPauseNavigation()
}

class ParknavMBNavigationPresenter: ParknavPresenter, ParknavMBNavigationPresentationLogic {
    func presentParkingInstruction(waypointsCount: Int) {
        guard let viewController = viewController as? ParknavMBNavigationDisplayLogic else {return}
        viewController.displayParkingInstruction(isDestination: waypointsCount > 2)
    }

    func presentExitNavigation(response: ParknavNavigation.Exit.Response) {
        guard let viewController = viewController as? ParknavMBNavigationDisplayLogic else {return}
        viewController.displayExitNavigation(viewModel: ParknavNavigation.Exit.ViewModel(navigationObject: nil, isPaused: false))
    }

    func presentPauseNavigation() {
        guard let viewController = viewController as? ParknavMBNavigationDisplayLogic else {return}
        viewController.displayPauseNavigation()
    }
}
