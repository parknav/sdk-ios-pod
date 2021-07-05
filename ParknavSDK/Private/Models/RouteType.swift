//
//  RouteType.swift
//  ParknavSDK
//

import Foundation

enum RouteType {
    case destination
    case parking

    var image: UIImage {
        switch self {
        case .destination: return UIImage(named: "Orange_Pin", in: Bundle.mainSDKBundle, compatibleWith: nil) ?? UIImage()
        case .parking: return UIImage(named: "Parking", in: Bundle.mainSDKBundle, compatibleWith: nil) ?? UIImage()
        }
    }
}
