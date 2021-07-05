//
//  ParknavNavigationPreviewViewController.swift
//  ParknavSDK
//
//

import UIKit
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import Mapbox

/**
View controller incapsulating all the functionality for the navigation to the parking with the specified parameters
 including the route preview on the map
 */
public class ParknavNavigationPreviewViewController: ParknavNavigationViewController {

    // MARK: - Outlets

    @IBOutlet var timeLeftLebel: UILabel!
    @IBOutlet var distanceLeftLabel: UILabel!
    @IBOutlet var bottomBannerView: BannerContainerView!

    @IBOutlet var bottomBannerViewBottom: NSLayoutConstraint!
    @IBOutlet var bottomBannerViewHeight: NSLayoutConstraint!

    @IBOutlet var routeMessageView: RouteMessageView!
    @IBOutlet var mapCenterImageView: UIImageView!
    @IBOutlet var recenterButton: UIButton!

    @IBOutlet var startNavigationButton: RoundButton!

    @IBOutlet var garageInfoView: BannerContainerView!
    @IBOutlet var garageNameLabel: UILabel!
    @IBOutlet var garageAddressLabel: UILabel!
    @IBOutlet var garageInfoViewHeight: NSLayoutConstraint!
    @IBOutlet var garageInfoViewBottom: NSLayoutConstraint!

    // MARK: - Private properties

    lazy var currentStatusBarStyle: UIStatusBarStyle = .default

    open override var preferredStatusBarStyle: UIStatusBarStyle { currentStatusBarStyle }

    // MARK: - Class functions

    /**
     Present `ParknavNavigationPreviewViewController` modally from the specified view controoler

     - parameter viewController: View controller to be present from
     - parameter options: ParknavRouteOptions for the navigation
     - returns: created and presented `ParknavNavigationPreviewViewController`
     */
    override class public func presentFrom(_ viewController: UIViewController,
                                           options: ParknavRouteOptions?) -> ParknavNavigationPreviewViewController? {
        guard let parknavNC =
                UIStoryboard(name: "ParknavNavigationWithPreview",
                             bundle: Bundle.mainSDKBundle).instantiateInitialViewController() as? UINavigationController,
            let parknavNavigationVC = parknavNC.viewControllers.first as? ParknavNavigationPreviewViewController
        else { return nil }
        parknavNavigationVC.setup(options)
        if options?.isFullscreen == true { parknavNC.modalPresentationStyle = .fullScreen }
        viewController.present(parknavNC, animated: true, completion: nil)
        return parknavNavigationVC
    }

    /**
     Present `ParknavNavigationPreviewViewController` in primary context from the specified view controoler

     - parameter viewController: View controller to be present from
     - parameter options: ParknavRouteOptions for the navigation
     - returns: created and presented `ParknavNavigationPreviewViewController`
     */
    override class public func showFrom(_ viewController: UIViewController,
                                        options: ParknavRouteOptions?) -> ParknavNavigationPreviewViewController? {
        guard let parknavNC =
                UIStoryboard(name: "ParknavDestinationNavigation",
                             bundle: Bundle.mainSDKBundle).instantiateInitialViewController() as? UINavigationController,
            let parknavNavigationVC = parknavNC.viewControllers.first as? ParknavNavigationPreviewViewController
        else { return nil }
        parknavNavigationVC.setup(options)
        viewController.show(parknavNavigationVC, sender: nil)
        return parknavNavigationVC
    }

    // MARK: Setup

    override func setup(_ options: ParknavRouteOptions?) {
        interactor = ParknavNavigationPreviewInteractor(parknavRouteOptions: options ?? ParknavRouteOptions.instance)
        let presenter = ParknavNavigationPreviewPresenter()
        presenter.viewController = self
        router = ParknavNavigationPreviewRouter()
        (interactor as?  ParknavNavigationPreviewInteractor)?.presenter = presenter
        (router as? ParknavNavigationPreviewRouter)?.viewController = self
        (router as? ParknavNavigationPreviewRouter)?.dataStore = interactor as? ParknavNavigationDataStore
    }

    // MARK: - ParknavNavigationDisplayLogic

    override func displayNavigation(viewModel: ParknavNavigation.State.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.clearMap()
            self?.lockScreen(false, parknavOptions: self?.interactor?.parknavRouteOptions)
            self?.localInteractor?.prepareGarages(self?.mapView)
            guard let route = self?.interactor?.route else { return }
            self?.showRoute(route)
        }
    }

    override func configureNavigation(_ route: Route, isDestination: Bool) {
        guard !(interactor?.isRouting ?? false) else { return }
        interactor?.isRouting = true
        guard let directions = interactor?.directions else {return}
        let parknavRouteOptions = interactor?.parknavRouteOptions ?? ParknavRouteOptions.instance
        navigationViewController =
            ParknavMBNavigationViewController(for: route, directions: directions,
                                              styles: [ParknavDayStyle(parknavRouteOptions),
                                                       ParknavNightStyle(parknavRouteOptions)],
                                              locationManager: NavigationLocationManager(),
                                              eventsListener: delegate,
                                              locationHistoryService: interactor?.locationHistoryService
                                                ?? LocationHistoryService(parknavOptions: parknavRouteOptions),
                                              parknavRouteOptions: parknavRouteOptions)
        navigationViewController?.displayOnParentViewController(self, isDestination: isDestination)
    }

    override func displayExitNavigation(viewModel: ParknavNavigation.Exit.ViewModel) {
        guard !viewModel.isPaused else {
            navigationViewController = nil
            localInteractor?.processPauseNavigation(viewModel.navigationObject)
            return
        }
        super.displayExitNavigation(viewModel: viewModel)
    }

    // MARK: - Touch events

    @IBAction func recenterButtonTouch(_ sender: Any) {
        localInteractor?.prepareToRecenterMap(mapView?.userLocation?.coordinate)
    }

    @IBAction func startNavigationButtonTouch(_ sender: Any) {
        localInteractor?.prepareToStartNavigation()
    }

    @IBAction func closwGarageInfoButtonTouch(_ sender: Any) {
        localInteractor?.prepareToCloseGarageInfo()
    }

    @IBAction func startNavigationToGarageButtonTouch(_ sender: Any) {
        localInteractor?.prepareToStartNavigationToGarage()
    }

}
