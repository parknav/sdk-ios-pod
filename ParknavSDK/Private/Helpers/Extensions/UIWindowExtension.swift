//
//  UIWindowExtension.swift
//  ParknavSDK
//

import UIKit

extension UIWindow {
    func topMostWindowController() -> UIViewController? {
        var topController = rootViewController
        while let presentedController = topController?.presentedViewController {
            topController = presentedController }
        return topController
    }

    func currentViewController() -> UIViewController? {
        var currentViewController = topMostWindowController()
        while let topVC = (currentViewController as? UINavigationController)?.topViewController {
            currentViewController = topVC }
        return currentViewController
    }
}
