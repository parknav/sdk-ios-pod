//
//  ParknavNavigationPresenter.swift
//  ParknavSDK
//

import UIKit

protocol ParknavNavigationPresentationLogic: ParknavPresentationLogic {
    func presentCurrentLocation(response: ParknavNavigation.CurrentLocation.Response)
    func presentAppSettingsAlert()
    func presentMapView()
    func presentCloseNavigation(response: ParknavNavigation.Exit.Response)
}

class ParknavNavigationPresenter: ParknavPresenter, ParknavNavigationPresentationLogic {
    // MARK: - ParknavNavigationPresentationLogic

    func presentCurrentLocation(response: ParknavNavigation.CurrentLocation.Response) {
        guard let viewController = viewController as? ParknavNavigationDisplayLogic else {return}
        viewController.displayCurrentLocation(viewModel: ParknavNavigation.CurrentLocation.ViewModel(location: response.location))
    }

    func presentMapView() {
        guard let viewController = viewController as? ParknavNavigationDisplayLogic else {return}
        viewController.displayStartDetectingLocation()
    }

    func presentAppSettingsAlert() {
        guard let viewController = viewController as? ParknavNavigationDisplayLogic else {return}
        viewController.displayAppSettingsAlert()
    }

    func presentCloseNavigation(response: ParknavNavigation.Exit.Response) {
        viewController?.displayExitNavigation(viewModel: ParknavNavigation.Exit
                                                .ViewModel(navigationObject: response.navigationObject, isPaused: false))
    }

}
