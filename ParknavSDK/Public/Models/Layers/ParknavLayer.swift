//
//  ParknavLayer.swift
//  ParknavSDK

import Foundation
import CoreLocation
import Mapbox

/**
 Base class for the Parknav Layers managing objects' classes
 */
public class ParknavLayer {
    // MARK: - Private properties

    internal var destination: CLLocationCoordinate2D
    internal var currentLocation: CLLocationCoordinate2D?

    // MARK: - Object lifecycle

    /**
     `ParknavLayer` object initializer

     - parameter destination: Destination location
     - parameter currentLocation: Current user's location
     */
    public required init(destination: CLLocationCoordinate2D,
                         currentLocation: CLLocationCoordinate2D?) {
        self.destination = destination
        self.currentLocation = currentLocation
    }

    // MARK: - Public functions

    /**
     Display the layer on the map

     - Parameter mapView: mapView to display the layer on
     - Parameter shapeCollection: object of type MGLShapeCollectionFeature with all the geometric layer info
     */
    public func displayOnMap(_ mapView: MGLMapView, shapeCollection: MGLShapeCollectionFeature) {}
}
