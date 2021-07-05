//
//  ParknavBottomBannerViewController.swift
//  ParknavSDK
//

import UIKit
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import Mapbox

class ParknavBottomBannerViewController: BottomBannerViewController {
    weak var forwarder: ParknavMBNavigationViewController?

    func addBottomButton(colorsScheme: StyleColorsScheme?) {
        if let bottomConstraint = view.findConstraint(with: BottomBannerView.self,
                                                      firstAttribute: .bottom,
                                                      relation: .equal,
                                                      secondItemClass: BottomBannerView.self,
                                                      secondAttribute: .top) {
            NSLayoutConstraint.deactivate([bottomConstraint]) }

        let clearView = BottomBannerView()
        clearView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clearView)

        NSLayoutConstraint.activate([
            clearView.leadingAnchor.constraint(equalTo: view!.leadingAnchor), // L
            clearView.trailingAnchor.constraint(equalTo: view!.trailingAnchor), // R
            clearView.topAnchor.constraint(equalTo: bottomBannerView.bottomAnchor), // Top
            clearView.heightAnchor.constraint(equalToConstant: 80),
            clearView.bottomAnchor.constraint(equalTo: bottomPaddingView.topAnchor) // Bottom
            ])

        let bottomButton = RoundButton(type: .custom)
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.setTitle(LocalizedString.parkingFound.value, for: .normal)
        bottomButton.backgroundColor = colorsScheme?.instructionsBannerColor ?? #colorLiteral(red: 0, green: 0.6196078431, blue: 0.8745098039, alpha: 1)
        bottomButton.addTarget(self, action: #selector(parkingFoundButtonTouch), for: .touchUpInside)
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        clearView.addSubview(bottomButton)

        NSLayoutConstraint.activate([
            bottomButton.widthAnchor.constraint(equalTo: clearView.widthAnchor, multiplier: 330/375, constant: 0),
            bottomButton.centerXAnchor.constraint(equalTo: clearView.centerXAnchor),
            bottomButton.heightAnchor.constraint(equalTo: clearView.heightAnchor, multiplier: 0.6, constant: 0),
            bottomButton.centerYAnchor.constraint(equalTo: clearView.centerYAnchor, constant: 0)
            ])

    }

    @objc func parkingFoundButtonTouch() { forwarder?.parkingFoundButtonTouch() }
}
