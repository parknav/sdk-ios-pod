//
//  ParknavEventsListener.swift
//  ParknavSDK
//

import Foundation
import CoreLocation
import MapboxDirections

/**
 Parknav navigation events listener protocol
 
 ParknavSDK calls the methods of this protocol to notify about some navigation events inside of the navigation objects
 */
public protocol ParknavEventsListener: AnyObject {
    /**
     Asks whether one of the Parknav navigation view controllers should be allowed to calculate a new route.

     - parameter location: The user’s current location.
     - returns: True to allow the Parknav navigation view controller to calculate a new route;
     false to keep tracking the current route.
     */
    func shouldReroute(from location: CLLocation) -> Bool
    /**
     Called when the navigation was finished

     - parameter navigationObject: The instance of `ParknavNavigationObject` with the result of nuvigation.
     */
    func navigationExit(_ navigationObject: ParknavNavigationObject)
    func didChangeRoute(_ route: Route)
    /**
     Called when one of the Parknav navigation view controllers arrived to the parking
     and asks whether it should continue navigation or not.

     - parameter waipoint:  The instance of `Waypoint` which contains the inforation about the user's current location
     - returns: True to signal that the user has actually arrived at the parking and there is no need to continue navigation;
     false in the opposite case
     */
    func didArriveToParking(_ waipoint: Waypoint) -> Bool
}
