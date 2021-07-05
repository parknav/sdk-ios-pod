//
//  RouteType.swift
//  ParknavSDK
//
//  Created by Ekaterina Kharlamova on 02/06/2021.
//  Copyright © 2021 AI Incube. All rights reserved.
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
