//
//  ParknavNavigationWithPreviewViewControllerExtension.swift
//  ParknavSDK
//

import Foundation
import Mapbox
import MapboxDirections

protocol ParknavNavigationPreviewDisplayLogic: AnyObject {
    func displayNavigationController(viewModel: ParknavNavigation.State.ViewModel)
    func displayArrivalValues(viewModel: ParknavNavigationPreview.Arrival.ViewModel)
    func displayRecenteredMap(_ coordinates: CLLocationCoordinate2D)
    func displayMapStyle(viewModel: ParknavNavigationPreview.MapStyle.ViewModel)
    func displayReloadedMapStyle()
    func displayGarages()
    func displayGarageInfo(viewModel: ParknavNavigationPreview.Garage.ViewModel)
    func displayCloseGarageInfo()
}

// MARK: - Internal

extension ParknavNavigationPreviewViewController {
    var localInteractor: ParknavNavigationPreviewBusinessLogic? {
        interactor as? ParknavNavigationPreviewBusinessLogic
    }

    override func configureViews() {
        super.configureViews()
        startNavigationButton.setTitle(LocalizedString.startNavigation.value, for: .normal)
        if let allowDestinationSelection = interactor?.parknavRouteOptions.allowDestinationSelection {
            mapCenterImageView.isHidden = !allowDestinationSelection
        }
        if let colorScheme = (interactor?.parknavRouteOptions ?? ParknavRouteOptions.instance).dayStyle?.colorsScheme {
            startNavigationButton.backgroundColor = colorScheme.instructionsBannerColor
        }
    }

    func clearMap() {
        mapView?.removeRoutes()
        mapView?.removeWaypoints()
        showBottomView(false)
        showRouteMessage(false)
    }

    func showRoute(_ route: Route) {
        mapView?.showRoutes([route])
        mapView?.showWaypoints(route)
        showBottomView(true)
        showRouteMessage(true, routeMessage: route.routeMessage)

        if localInteractor?.isInitialLoading ?? false, let coordinates = route.coordinates {
            mapView?.setVisibleCoordinates(coordinates, count: UInt(coordinates.count),
                                           edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: false) }
        localInteractor?.prepareArrivalValues()
    }
}

// MARK: - Private

private extension ParknavNavigationPreviewViewController {
    func showBottomView(_ isVisible: Bool) {
        bottomBannerViewHeight.constant = view.safeArea.bottom + ParknavConstans.UI.bottomBannerViewHeight
        bottomBannerViewBottom.constant = !isVisible ? bottomBannerView.frame.height : 0
    }

    func showRouteMessage(_ isVisible: Bool, routeMessage: RouteMessage? = nil) {
        routeMessageView.isHidden = !isVisible
        guard let routeMessage = routeMessage else {
            routeMessageView.isHidden = true
            return}
        routeMessageView.messageText = routeMessage.message
        routeMessageView.messageColor = routeMessage.color
        routeMessageView.messageImage = RouteMessage.MessageType(rawValue: routeMessage.type)?.image
    }

    func showGarageInfoView(_ isVisible: Bool) {
        garageInfoViewHeight.constant = view.safeArea.bottom + ParknavConstans.UI.bottomBannerViewHeight
        garageInfoViewBottom.constant = !isVisible ? garageInfoView.frame.height : 0
    }

    func showGarageInfo(_ isVisible: Bool, garageInfoModel: ParknavNavigationPreview.Garage.ViewModel? = nil) {
        garageInfoView.isHidden = !isVisible
        guard let garageInfoModel = garageInfoModel else {
            garageInfoView.isHidden = true
            return}
        garageNameLabel.text = garageInfoModel.name + " " + garageInfoModel.price
        garageAddressLabel.text = garageInfoModel.address
    }
}

// MARK: - ParknavNavigationPreviewDisplayLogic

extension ParknavNavigationPreviewViewController: ParknavNavigationPreviewDisplayLogic {
    func displayNavigationController(viewModel: ParknavNavigation.State.ViewModel) {
        guard let route = viewModel.route ?? interactor?.route else { return }
        DispatchQueue.main.async { [weak self] in
            self?.displayCloseGarageInfo()
            self?.configureNavigation(route, isDestination: viewModel.isDestination)
        }
    }

    func displayArrivalValues(viewModel: ParknavNavigationPreview.Arrival.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.timeLeftLebel.text = viewModel.expectedTime
            self?.distanceLeftLabel.text = viewModel.expectedDistance
        }
    }

    func displayRecenteredMap(_ coordinates: CLLocationCoordinate2D) {
        DispatchQueue.main.async { [weak self] in
            self?.mapView?.setCenter(coordinates, animated: true)
        }
    }

    func displayMapStyle(viewModel: ParknavNavigationPreview.MapStyle.ViewModel) {
        if mapView?.styleURL != viewModel.style.mapStyleURL {
            mapView?.style?.transition = MGLTransition(duration: 0.5, delay: 0)
            mapView?.styleURL = viewModel.style.mapStyleURL
        }

        currentStatusBarStyle = viewModel.style.statusBarStyle ?? .default
        DispatchQueue.main.async { [weak self] in self?.setNeedsStatusBarAppearanceUpdate() }
    }

    func displayReloadedMapStyle() {
        DispatchQueue.main.async { [weak self] in self?.mapView?.reloadStyle(self) }
    }

    func displayGarages() {
        DispatchQueue.main.async { [weak self] in
            self?.lockScreen(false, parknavOptions: self?.interactor?.parknavRouteOptions)
            self?.localInteractor?.prepareGarages(self?.mapView)
        }
    }

    func displayGarageInfo(viewModel: ParknavNavigationPreview.Garage.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.showGarageInfoView(true)
            self?.showGarageInfo(true, garageInfoModel: viewModel)
        }
    }

    func displayCloseGarageInfo() {
        DispatchQueue.main.async { [weak self] in
            self?.showGarageInfoView(false)
            self?.showGarageInfo(false)
        }
    }
}
