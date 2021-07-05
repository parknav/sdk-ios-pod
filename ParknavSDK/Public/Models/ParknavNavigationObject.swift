//
//  ParknavNavigationObject.swift
//  ParknavSDK

import Foundation
import CoreLocation

/**
 Result of navigation of any type
 */
public struct ParknavNavigationObject {
    /**
     Navigation exit type
     */
    public var exitType: NavigationExitType = .normal

    /**
     Last detected user's location
     */
    public var lastUserLocation: CLLocation?
}
