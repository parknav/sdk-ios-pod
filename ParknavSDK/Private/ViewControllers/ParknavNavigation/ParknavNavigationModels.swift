//
//  ParknavNavigationModels.swift
//  ParknavSDK
//

import UIKit
import CoreLocation
import MapboxDirections

enum ParknavNavigation {
    // swiftlint:disable nesting
    enum CurrentLocation {
        struct Request {}
        struct Response {
            var location: CLLocationCoordinate2D = ParknavConstans.Location.defaultLocation
        }
        struct ViewModel {
            var location: CLLocationCoordinate2D
        }
    }

    enum Error {
        struct Request {}
        struct Response {
            var error: NSError = ParknavConstans.Errors.locationNotDetected
        }
        struct ViewModel {
            var reason: String
        }
    }

    enum State {
        struct Request {}
        struct Response {
            var waypointsCount: Int = 0
            var route: Route?
            var waypoints = [Waypoint]()
        }
        struct ViewModel {
            var isDestination = true
            var route: Route?
            var waypoints = [Waypoint]()
        }
    }

    enum Exit {
        struct Request {}
        struct Response {
            var navigationObject: ParknavNavigationObject?
        }
        struct ViewModel {
            var navigationObject: ParknavNavigationObject?
            var isPaused: Bool = false
        }
    }
    // swiftlint:enable nesting
}
