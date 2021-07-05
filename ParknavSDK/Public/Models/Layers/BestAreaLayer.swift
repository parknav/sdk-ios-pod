//
//  BestAreaLayer.swift
//  ParknavSDK

import UIKit
import CoreLocation
import Mapbox

/**
 Class for the Parknav Best Area Layer managing object
 
 Best Area Layer presens the polygon area with the maximal parking probability on the map.
 */
public class BestAreaLayer: ParknavLayer {
    // MARK: - Private properties

    internal var radius: Int? = ParknavConstans.Layers.radius
    internal var minSize: Int?
    internal var maxSize: Int?
    internal var numAreas: Int?

    // MARK: - Object lifecycle

    /**
     `BestAreaLayeru` object initializer

     - parameter destination: Destination location
     - parameter currentLocation: Current user's location
     */
    public required init(destination: CLLocationCoordinate2D, currentLocation: CLLocationCoordinate2D?) {
        super.init(destination: destination, currentLocation: currentLocation)
    }

    // MARK: - Public functions

    /**
     Display the layer on the map

     - Parameter mapView: mapView to display the layer on
     - Parameter shapeCollection: object of type MGLShapeCollectionFeature with all the geometric layer info
     */
    public override func displayOnMap(_ mapView: MGLMapView, shapeCollection: MGLShapeCollectionFeature) {
        let polygons = shapeCollection.shapes.map { $0 as? MGLPolygonFeature }.filter { $0 != nil }
        DispatchQueue.main.async {
            if !polygons.isEmpty {
                mapView.addAnnotations(polygons as? [MGLAnnotation] ?? [])
            }
        }
    }
}
