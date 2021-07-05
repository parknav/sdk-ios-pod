//
//  LocalizedString.swift
//  ParknavSDK
//
//

import Foundation

enum LocalizedString: String {
    // swiftlint:disable identifier_name
    case locationDisabled
    case error
    case warning
    case ok
    case cancel
    case locationNotDetected
    case unknownError
    case networkError
    case emptyRoute
    case startNavigation
    case parkingFound
    case selfError
    // swiftlint:enable identifier_name

    var deafultValue: String {
        switch self {
        case .locationDisabled: return "The location access is disabled."
        case .error: return "Error"
        case .warning: return "Warning"
        case .ok: return "OK"
        case .cancel: return "Cancel"
        case .locationNotDetected: return "Location could not be detected"
        case .unknownError: return "Unknown error"
        case .networkError: return "Network is unavailable"
        case .emptyRoute: return "The route is not detected"
        case .startNavigation: return "Start navigation"
        case .parkingFound: return "Parking found"
        case .selfError: return "Self == nil"
        }
    }

    var value: String {
        Bundle.mainSDKBundle.localizedString(forKey: self.rawValue, value: self.deafultValue, table: nil) }
}
