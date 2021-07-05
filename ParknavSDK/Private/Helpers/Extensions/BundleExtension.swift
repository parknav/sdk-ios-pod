//
//  BundleExtension.swift
//  ParknavSDK
//

import Foundation

extension Bundle {
    static var versionString: String { mainSDKBundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? "" }

    static var mainSDKBundle: Bundle { Bundle(for: ParknavNavigationViewController.self) }

    static func version(_ bundle: Bundle) -> String { bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? "" }
}
