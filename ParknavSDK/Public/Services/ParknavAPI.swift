//
//  ParknavAPI.swift
//  ParknavSDK

import Foundation
import BrightFutures
import CoreLocation
import Mapbox

/**
Service for the intercation with Parknav API
 */
public class ParknavAPI {
    /**
     Request for the itinerary between the current location and the most optimal parking near the destination or current location

     - parameter currentLocation: The user’s current location.
     - parameter currentAngle: The angle of the navigation, `default` is 0
     - parameter options: `ParknavRouteOptions object with parameters for the route creation
     - returns: if success: `DirectionsResponse` object, if failure: error
     */
    public class func getDirections(currentLocation: CLLocationCoordinate2D,
                                    currentAngle: Double = 0,
                                    options: ParknavRouteOptions) -> Future<DirectionsResponse, NSError> {
        let promise = Promise<DirectionsResponse, NSError>()
        ParknavNavigationWorker().getRoute(currentLocation, currentAngle: currentAngle, options: options)
            .onSuccess { response in
                promise.success(response)
            }.onFailure { error in
                promise.failure(error)
            }
        return promise.future
    }

    /**
     Request for the parking probability layer

     - parameter layer: Parknav layer managing object
     - parameter serverInfo: Information about the used Parknav API, contains URL and API key
     - returns: if success: `MGLShapeCollectionFeature` object — GeoJSON with the information
     for displaying the layer on the map, if failure: error
     */
    public class func getLayer(_ layer: ParknavLayer, serverInfo: ServerInfo?) ->
        Future<MGLShapeCollectionFeature, NSError> {
        let promise = Promise<MGLShapeCollectionFeature, NSError>()
        ParknavServiceHelper.instance.serverInfo = serverInfo
        ParknavLayersService.getLayer(layer, countOfTries: 0)
            .onSuccess { shapeObject in
                promise.success(shapeObject)
            }.onFailure { error in
                promise.failure(error)
            }
        return promise.future
    }
}
