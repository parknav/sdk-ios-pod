//
//  UIViewControllerExtension.swift
//  ParknavSDK
//

import UIKit

extension UIViewController {
    class var storyboardID: String { "\(self)" }

    static func instantiateFromAppStoryboard(appStoryboard: AppStoryboard) -> Self {
        appStoryboard.viewController(viewControllerClass: self) }

    func showError(_ error: NSError, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: ParknavConstans.Titles.errorAlertTitle,
                                      message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: ParknavConstans.Titles.alertOK,
                                   style: .default) { _ in completion?() }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func addToParentViewController(_ parentVC: UIViewController) {
        parentVC.addChild(self)
        parentVC.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: parentVC.view.leadingAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: parentVC.view.trailingAnchor, constant: 0),
            view.topAnchor.constraint(equalTo: parentVC.view.topAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: parentVC.view.bottomAnchor, constant: 0)
            ])
        parentVC.didMove(toParent: parentVC)
    }

    func lockScreen(_ setLock: Bool, parknavOptions: ParknavRouteOptions?) {
        guard let window = UIApplication.shared.windows.first else {return}

        if setLock {
            let lockVC = LockViewController.instantiateFromAppStoryboard(appStoryboard: .ParknavNavigation)
            lockVC.view.tag = Int.max
            lockVC.applyStyle(parknavOptions?.dayStyle?.colorsScheme)
            window.topMostWindowController()?.view.addSubview(lockVC.view)
        } else
            if let lockView = (window.topMostWindowController()?.view.subviews.filter { $0.tag == Int.max })?.first {
                lockView.removeFromSuperview()
        }
    }
}
