//
//  ParknavPresenter.swift
//  ParknavSDK
//

import UIKit

protocol ParknavPresentationLogic {
    func presentError(response: ParknavNavigation.Error.Response)
    func presentNavigation(response: ParknavNavigation.State.Response)
    func presentStopNavigation()
}

class ParknavPresenter: ParknavPresentationLogic {
    weak var viewController: ParknavDisplayLogic?

    // MARK: - ParknavPresentationLogic

    func presentError(response: ParknavNavigation.Error.Response) { viewController?.displayError(response.error) }

    func presentNavigation(response: ParknavNavigation.State.Response) {
        var viewModel = ParknavNavigation.State.ViewModel()
        viewModel.waypoints = response.waypoints
        viewModel.route = response.route
        viewModel.isDestination = response.waypointsCount > 2
        viewController?.displayNavigation(viewModel: viewModel)
    }

    func presentStopNavigation() { viewController?.displayStopNavigation() }
}
