//
//  ParknavNavigationViewController.swift
//  ParknavSDK
//

import UIKit
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import Mapbox
import MapboxSpeech

/**
View controller incapsulating all the functionality for the navigation to the parking with the specified parameters
 */
public class ParknavNavigationViewController: UIViewController {
    // MARK: - Internal properties

    var interactor: ParknavNavigationBusinessLogic?
    lazy var router: (NSObjectProtocol & ParknavNavigationRoutingLogic &
                      ParknavNavigationDataPassing)? = ParknavNavigationRouter()
    lazy var mapView: NavigationMapView! = NavigationMapView(frame: UIScreen.main.bounds)
    var navigationViewController: ParknavMBNavigationViewController?

    private var didTransition = false

    // MARK: - Public properties

    /**
     Object which implement Parknav navigation events listener protocol
     */
    public var delegate: ParknavEventsListener? {
        didSet { interactor?.delegate = delegate }
    }

    // MARK: - Class functions

    /**
     Present `ParknavNavigationViewController` modally from the specified view controoler

     - parameter viewController: View controller to be present from
     - parameter options: ParknavRouteOptions for the navigation
     - returns: created and presented `ParknavNavigationViewController`
     */
    class public func presentFrom(_ viewController: UIViewController,
                                  options: ParknavRouteOptions?) -> ParknavNavigationViewController? {
        guard let parknavNC =
                UIStoryboard(name: "ParknavNavigation",
                             bundle: Bundle.mainSDKBundle).instantiateInitialViewController() as? UINavigationController,
              let parknavNavigationVC = parknavNC.viewControllers.first as? ParknavNavigationViewController else { return nil }
        parknavNavigationVC.setup(options)
        if options?.isFullscreen == true {
            parknavNC.modalPresentationStyle = .fullScreen
        }
        viewController.present(parknavNC, animated: true, completion: nil)
        return parknavNavigationVC
    }

    /**
     Present `ParknavNavigationViewController` in primary context from the specified view controoler

     - parameter viewController: View controller to be present from
     - parameter options: ParknavRouteOptions for the navigation
     - returns: created and presented `ParknavNavigationViewController`
     */
    class public func showFrom(_ viewController: UIViewController,
                               options: ParknavRouteOptions?) -> ParknavNavigationViewController? {
        guard let parknavNC =
                UIStoryboard(name: "ParknavNavigation",
                             bundle: Bundle.mainSDKBundle).instantiateInitialViewController() as? UINavigationController,
              let parknavNavigationVC = parknavNC.viewControllers.first as? ParknavNavigationViewController else {return nil}
        parknavNavigationVC.setup(options)
        viewController.show(parknavNavigationVC, sender: nil)
        return parknavNavigationVC
    }

    // MARK: - Object lifecycle

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    deinit {
        interactor = nil
        router = nil
        mapView = nil
        navigationViewController = nil
    }

    // MARK: Setup

    func setup(_ options: ParknavRouteOptions?) {
        RouteControllerProactiveReroutingInterval = 36000
        interactor = ParknavNavigationInteractor(parknavRouteOptions: options ?? ParknavRouteOptions.instance)
        let presenter = ParknavNavigationPresenter()
        presenter.viewController = self
        (interactor as? ParknavNavigationInteractor)?.presenter = presenter
        (router as? ParknavNavigationRouter)?.viewController = self
        (router as? ParknavNavigationRouter)?.dataStore =
            interactor as? ParknavNavigationDataStore
    }

    // MARK: Routing

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: - View lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        if !didTransition {
//            lockScreen(true, parknavOptions: interactor?.parknavRouteOptions)
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !didTransition {
            didTransition = false
            interactor?.checkLocationAccess()
        }
    }

    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        didTransition = true
    }

    // MARK: - Touch events

    @IBAction func stopButtonTouch(_ sender: Any) {
        interactor?.prepareToCloseNavigation()
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let colorsScheme = interactor?.parknavRouteOptions.dayStyle?.colorsScheme
        else { return .default }
        return colorsScheme.statusBarStyle
    }

    // MARK: - Private functions

    func configureNavigation(_ route: Route, isDestination: Bool) {
        guard !(interactor?.isRouting ?? false) else { return }
        interactor?.isRouting = true
        guard let directions = interactor?.directions else {return}
        let parknavRouteOptions = interactor?.parknavRouteOptions ?? ParknavRouteOptions.instance
        navigationViewController =
            ParknavMBNavigationViewController(for: route,
                                              directions: directions,
                                              styles: [ParknavDayStyle(parknavRouteOptions),
                                                       ParknavNightStyle(parknavRouteOptions)],
                                              locationManager: NavigationLocationManager(),
                                              eventsListener: delegate,
                                              locationHistoryService: interactor?.locationHistoryService
                                                ?? LocationHistoryService(parknavOptions: parknavRouteOptions),
                                              parknavRouteOptions: parknavRouteOptions)
        navigationViewController?.displayOnParentViewController(self, isDestination: isDestination)
    }

    // MARK: - ParknavNavigationDisplayLogic

    func displayNavigation(viewModel: ParknavNavigation.State.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.lockScreen(false, parknavOptions: self?.interactor?.parknavRouteOptions)
            guard let route = viewModel.route ?? self?.interactor?.route else {return}
            self?.configureNavigation(route, isDestination: viewModel.isDestination)
        }
    }

    func displayExitNavigation(viewModel: ParknavNavigation.Exit.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.router?.closeNavigation { [weak self] in
                self?.interactor?.isRouting = false
                self?.navigationViewController = nil
                if let navigationObject = viewModel.navigationObject {
                    self?.delegate?.navigationExit(navigationObject)
                }
            }
        }
    }
}
