//
//  ParkingChanceViewController.swift
//  ParknavSDK
//

import UIKit
import Mapbox

/**
View controller incapsulating all the functionality for displaying the parking probability layers and l
 aunching navigation to the parking with the specified parameters
 */
public class ParkingChanceViewController: UIViewController {

    // MARK: - Internal properties

    var interactor: ParkingChanceBusinessLogic?
    lazy var router: (NSObjectProtocol & ParkingChanceRoutingLogic & ParkingChanceDataPassing)? = ParkingChanceRouter()
    var mapView: MGLMapView!

    // MARK: - Class functions

    /**
     Present ParkingChance view controller from another one

     - Parameter viewController: view controller from which will be presented ParkingChance
     - Parameter layerRules: object with the information about layers to be displayed
     - Parameter options: ParknavRouteOptions to use for the ParkingChance functionality
     - Returns: ParkingChanceViewController object which was presented
     */
    class public func presentFrom(_ viewController: UIViewController,
                                  layerRules: LayerRules?,
                                  options: ParknavRouteOptions?) -> ParkingChanceViewController? {
        guard let parkingNC =
                UIStoryboard(name: "ParkingChance",
                             bundle: Bundle.mainSDKBundle).instantiateInitialViewController() as? UINavigationController,
              let parkingChanceVC = parkingNC.viewControllers.first as? ParkingChanceViewController else { return nil }
        parkingChanceVC.setup(layerRules, options: options)
        parkingNC.modalPresentationStyle = .overCurrentContext
        viewController.present(parkingNC, animated: true, completion: nil)
        return parkingChanceVC
    }

    // MARK: - Object lifecycle

    deinit {
        interactor = nil
        router = nil
        mapView = nil
    }

    // MARK: - Routing

    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: - View lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
//        configureMapView()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureMapView()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.prepareToRecenterMap(true)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        deactivateMapView()
        interactor?.prepareToClose()
        super.viewWillDisappear(animated)
    }

    // MARK: - Touch events

    @IBAction func recenterButtonTouch(_ sender: Any) {
        interactor?.prepareToRecenterMap(false)
    }

    @IBAction func closeButtonTouch(_ sender: Any) {
        dismiss(animated: true) {}
    }
}
