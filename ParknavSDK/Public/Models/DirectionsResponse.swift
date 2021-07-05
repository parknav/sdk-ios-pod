//
//  DirectionsResponse.swift
//  ParknavSDK
//

import Foundation
import MapboxDirections

/**
 `DirectionsResponse` structure contains the information about the itinerary from the current location
 to the parking nearest to the destination, recived after request to the Parknav API
 */
public struct DirectionsResponse {
    /**
     Result of the request: Ok if the itinerary was built successfully
     */
    var code: String = ""
    /**
     List of the itinerary's waipoints
     */
    var waypoints = [Waypoint]()
    /**
     List of the possible routes
     */
    var routes = [Route]()
    /**
     Identifier of the itinerary
     */
    var uuid: String = ""
    /**
     Base URL
     */
    var baseURL: String = ""
    /**
     Geometries describing the route's shape
     */
    var geometries = [String]()
}
