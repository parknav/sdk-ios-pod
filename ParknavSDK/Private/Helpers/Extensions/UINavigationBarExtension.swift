//
//  UINavigationBarExtension.swift
//  ParknavSDK
//

import UIKit

extension UINavigationBar {
    func applyColorScheme(_ scheme: StyleColorsScheme) {
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: scheme.primaryLabelColor]
        tintColor = scheme.primaryLabelColor
        setBackgroundImage(UIImage.imageWithColor(scheme.instructionsBannerColor), for: .default)
        isTranslucent = false
    }
}
