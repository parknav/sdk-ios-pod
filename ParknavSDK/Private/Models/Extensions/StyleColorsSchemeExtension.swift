//
//  StyleColorsSchemeExtension.swift
//  ParknavSDK
//

import Foundation

extension StyleColorsScheme {
    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .silverMagenta: return .lightContent
        }
    }

    var bottomBannerColor: UIColor {
        switch self {
        case .silverMagenta: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }

    var primaryLabelColor: UIColor {
        switch self {
        case .silverMagenta: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }

    var instructionsBannerColor: UIColor {
        switch self {
        case .silverMagenta: return #colorLiteral(red: 0.9176470588, green: 0.1647058824, blue: 0.5294117647, alpha: 1)
        }
    }

    var routeColor: UIColor {
        switch self {
        case .silverMagenta: return #colorLiteral(red: 0.9188914895, green: 0.1661199331, blue: 0.5287303925, alpha: 1)
        }
    }

    var wayNameColor: UIColor {
        switch self {
        case .silverMagenta: return #colorLiteral(red: 0.9188914895, green: 0.1661199331, blue: 0.5287303925, alpha: 1)
        }
    }

    var mapStyleURL: String? {
        switch self {
        case .silverMagenta: return nil
        }
    }

    var userLocationFillColor: UIColor {
        switch self {
        case .silverMagenta: return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }

    var userLocationPuckColor: UIColor {
        switch self {
        case .silverMagenta: return #colorLiteral(red: 0.9188914895, green: 0.1661199331, blue: 0.5287303925, alpha: 1)
        }
    }

    var lockScreenImage: UIImage? {
        switch self {
        case .silverMagenta: return UIImage(named: "splash", in: Bundle.mainSDKBundle, compatibleWith: nil)
        }
    }
}
