//
//  ParknavNavigationPreviewPresenter.swift
//  ParknavSDK
//
//

import UIKit
import MapboxCoreNavigation
import MapboxDirections

protocol ParknavNavigationPreviewPresentationLogic {
  func presentNavigationController(response: ParknavNavigation.State.Response)
    func presentArrivalValues(response: ParknavNavigationPreview.Arrival.Response)
    func presentReceneteredMap(_ coordinates: CLLocationCoordinate2D)
    func presentMapStyle(response: ParknavNavigationPreview.MapStyle.Response)
    func presentReloadedMapStyle()
    func presentGarages()
    func presentGarageInfo(response: ParknavNavigationPreview.Garage.Response)
    func presentCloseGarageInfo()
}

class ParknavNavigationPreviewPresenter: ParknavNavigationPresenter, ParknavNavigationPreviewPresentationLogic {
    private var localViewController: ParknavNavigationPreviewDisplayLogic? {
        viewController as? ParknavNavigationPreviewDisplayLogic }

  // MARK: - ParknavDestinationNavigationPresentationLogic

    func presentNavigationController(response: ParknavNavigation.State.Response) {
        var viewModel = ParknavNavigation.State.ViewModel()
        viewModel.isDestination = response.waypointsCount > 2
        viewModel.route = response.route
        viewModel.waypoints = response.waypoints
        localViewController?.displayNavigationController(viewModel: viewModel)
    }

    func presentArrivalValues(response: ParknavNavigationPreview.Arrival.Response) {
        let distance = DistanceFormatter().string(from: response.expectedDistance)
//            DistanceFormatter(approximate: true)
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.hour, .minute]
        dateFormatter.unitsStyle = .abbreviated
        let time = dateFormatter.string(from: response.expectedTime) ?? ""
        localViewController?.displayArrivalValues(viewModel: ParknavNavigationPreview.Arrival
                                                    .ViewModel(expectedTime: time, expectedDistance: distance))
    }

    func presentReceneteredMap(_ coordinates: CLLocationCoordinate2D) { localViewController?.displayRecenteredMap(coordinates) }

    func presentMapStyle(response: ParknavNavigationPreview.MapStyle.Response) {
        localViewController?.displayMapStyle(viewModel: ParknavNavigationPreview.MapStyle.ViewModel(style: response.style))
    }

    func presentReloadedMapStyle() { localViewController?.displayReloadedMapStyle() }

    func presentGarages() { localViewController?.displayGarages() }

    func presentGarageInfo(response: ParknavNavigationPreview.Garage.Response) {
        let address = GaragesLayer.address(response.garage)
        let name = GaragesLayer.name(response.garage)
        let price = GaragesLayer.price(response.garage) > 0
            ? "(\(GaragesLayer.formattedPrice(response.garage)))" : GaragesLayer.formattedPrice(response.garage)
        localViewController?.displayGarageInfo(viewModel: ParknavNavigationPreview.Garage.ViewModel(address: address,
                                                                                                        name: name, price: price))
    }

    func presentCloseGarageInfo() { localViewController?.displayCloseGarageInfo() }
}
