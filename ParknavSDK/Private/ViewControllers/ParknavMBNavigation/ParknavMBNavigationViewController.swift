//
//  ParknavMBNavigationViewController.swift
//  ParknavSDK
//

import UIKit
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import Mapbox
import MapboxSpeech
import AVFoundation

protocol ParknavMBNavigationDisplayLogic: ParknavDisplayLogic {
    func displayParkingInstruction(isDestination: Bool)
    func displayExitNavigation(viewModel: ParknavNavigation.Exit.ViewModel)
    func displayPauseNavigation()
}

class ParknavMBNavigationViewController: NavigationViewController {
    // MARK: - Internal properties

    lazy var interactor: ParknavMBNavigationBusinessLogic? = ParknavMBNavigationInteractor()
    lazy var router: (NSObjectProtocol & ParknavMBNavigationRoutingLogic & ParknavMBNavigationDataPassing)? =
        ParknavMBNavigationRouter()
    var routeTypeView: RouteTypeView?
    weak var parentVC: ParknavDisplayLogic?

    lazy var bottomBanner: ParknavBottomBannerViewController? = ParknavBottomBannerViewController()

    lazy var routeMessageView: RouteMessageView? = { [weak self] in
        let messageView = RouteMessageView(frame: CGRect(x: 0, y: 0, width: self?.view.frame.width ?? 0, height: 80))
        messageView.translatesAutoresizingMaskIntoConstraints = false
        return messageView
    }()

    // MARK: Object lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        delegate = interactor as? NavigationViewControllerDelegate
    }

    deinit {
        interactor = nil
        router = nil
        bottomBanner = nil
    }

    init(for route: Route, directions: Directions, styles: [Style]?,
         locationManager: NavigationLocationManager?, eventsListener: ParknavEventsListener?,
         locationHistoryService: LocationHistoryService, parknavRouteOptions: ParknavRouteOptions) {
        print("ParknavMBNavigation: simulation: \(parknavRouteOptions.isSimulationEnabled)")
        let navigationService = MapboxNavigationService(route: route,
                                                        directions: directions,
                                                        locationSource: locationManager,
                                                        eventsManagerType: NavigationEventsManager.self,
                                                        simulating: parknavRouteOptions.isSimulationEnabled
                                                            ? SimulationMode.always : SimulationMode.never, routerType: nil)
        route.accessToken = ParknavConstans.API.mapboxAccessToken
        let navigationOptions = NavigationOptions(styles: styles, navigationService: navigationService)

        super.init(for: route, options: navigationOptions)

        setup()
        delegate = interactor as? NavigationViewControllerDelegate
        interactor?.route = route
        interactor?.directions = directions
        interactor?.delegate = eventsListener
        interactor?.locationHistoryService = locationHistoryService
        interactor?.parknavRouteOptions = parknavRouteOptions
    }

    @objc(initWithRoute:options:) required init(for route: Route, options: NavigationOptions? = nil) {
        super.init(for: route, options: options)
        delegate = interactor as? NavigationViewControllerDelegate
        interactor?.route = route
        interactor?.directions = navigationService.directions
        if let navigationService = options?.navigationService {
            interactor?.directions = navigationService.directions
        }
    }

    // MARK: Setup

    private func setup() {
        RouteControllerProactiveReroutingInterval = 36000
        let presenter = ParknavMBNavigationPresenter()
        (interactor as? ParknavMBNavigationInteractor)?.presenter = presenter
        presenter.viewController = self
        (router as? ParknavMBNavigationRouter)?.viewController = self
        (router as? ParknavMBNavigationRouter)?.dataStore = interactor as? ParknavMBNavigationDataStore
        configureNavigation()
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let scene = segue.identifier else { return }
        let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
        if let router = router, router.responds(to: selector) {
            router.perform(selector, with: segue)
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView?.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.checkParkingInstructions(nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        interactor?.unsubscribeFromNotifications()
        voiceController = nil
        navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillDisappear(animated)
    }

    // MARK: - Public functions

    func displayOnParentViewController(_ parentVC: UIViewController, isDestination: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.parentVC = parentVC as? ParknavDisplayLogic
            self?.addToParentViewController(parentVC)
            self?.navigationController?.setNavigationBarHidden(true, animated: true)
            self?.addBottomButton(isDestination: isDestination)
        }
    }

    // MARK: - Private functions

    private func configureNavigation() {
        bottomBanner?.forwarder = self
        interactor?.subscribeForNotifications()
        voiceController.voiceControllerDelegate = interactor as? VoiceControllerDelegate

        showsEndOfRouteFeedback = false
        annotatesSpokenInstructions = false
        showsReportFeedback = false
        if interactor?.parknavRouteOptions.isSimulationEnabled ?? false {
            navigationService.simulationMode = .always
            navigationService.locationManager.startUpdatingLocation()
        }
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }

    private func addBottomButton(isDestination: Bool) {
        guard interactor?.parknavRouteOptions.showRouteType ?? false else {return}

        bottomBanner?.addBottomButton(colorsScheme: interactor?.parknavRouteOptions.dayStyle?.colorsScheme)
        bottomBanner?.delegate = self

        guard let navigationView = view.findSubview(NavigationView.self) else {return}

        let mapView = navigationView.findSubview(NavigationMapView.self)
        interactor?.prepareGarages(mapView)
    }

    private func addParkingInstructionView(_ message: String) {
        guard let navigationView = view.findSubview(NavigationView.self),
            let bottomContentView = navigationView.findSubview(BannerContainerView.self),
            let routeMessageView = routeMessageView
            else {return}
        routeMessageView.messageColor = interactor?.parknavRouteOptions.dayStyle?.colorsScheme?.instructionsBannerColor ?? #colorLiteral(red: 0, green: 0.6196078431, blue: 0.8745098039, alpha: 1)
        routeMessageView.messageText = message
        navigationView.addSubview(routeMessageView)
        NSLayoutConstraint.activate([
            routeMessageView.leadingAnchor.constraint(equalTo: bottomContentView.leadingAnchor),
            routeMessageView.trailingAnchor.constraint(equalTo: bottomContentView.trailingAnchor),
            routeMessageView.heightAnchor.constraint(equalToConstant: 80),
            routeMessageView.bottomAnchor.constraint(equalTo: bottomContentView.topAnchor)])
        _ = Timer.scheduledTimer(timeInterval: ParknavConstans.Layers.showRouteMessageInterval,
                                 target: self,
                                 selector: #selector(hideParkingInstructionView),
                                 userInfo: nil, repeats: false)
    }

    @objc func hideParkingInstructionView() {
        DispatchQueue.main.async { [weak self] in
            self?.routeMessageView?.removeFromSuperview()
        }
    }

    @objc func parkingFoundButtonTouch() {
        interactor?.prepareToExitNavigation(navigationService.locationManager.location)
    }
}

// MARK: - ParknavMBNavigationDisplayLogic

extension ParknavMBNavigationViewController: ParknavMBNavigationDisplayLogic {
    func displayError(_ error: NSError) {
        DispatchQueue.main.async { [weak self] in
            self?.showError(error)
        }
    }

    func displayParkingInstruction(isDestination: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.addParkingInstructionView(self?.interactor?.route?.parkingMessage ?? "")
        }
    }

    func displayExitNavigation(viewModel: ParknavNavigation.Exit.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.navigationService.endNavigation(feedback: nil)
            self?.router?.closeNavigation()
        }
    }

    func displayNavigation(viewModel: ParknavNavigation.State.ViewModel) {
        guard let route = interactor?.route else { return }
        self.route = route
    }

    func displayStopNavigation() {
//        navigationService.stop()
        navigationService.endNavigation(feedback: nil)
    }

    func displayPauseNavigation() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationService.stop()
            self?.router?.pauseNavigation()
        }
    }
}

extension ParknavMBNavigationViewController: MGLMapViewDelegate {
   func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        guard let garage = annotation as? MGLPointFeature else {return nil}
        return GaragesLayer.icon(garage)
    }
}
