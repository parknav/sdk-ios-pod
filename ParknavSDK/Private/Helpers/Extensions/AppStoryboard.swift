//
//  AppStoryboard.swift
//  ParknavSDK
//

import UIKit

enum AppStoryboard: String {
    // swiftlint:disable identifier_name
    case ParknavNavigation
    case ParknavNavigationWithPreview
    case ParkingChance
    // swiftlint:enable identifier_name

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.mainSDKBundle)
    }

    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as? T ?? T()
    }

    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
