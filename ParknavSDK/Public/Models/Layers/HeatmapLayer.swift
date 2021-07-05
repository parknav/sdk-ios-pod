//
//  HeatmapLayer.swift
//  ParknavSDK

import UIKit
import CoreLocation
import Mapbox

/**
 Class for the Parknav Heatmap Layer managing object
 
 Heatmap Layer presens parking availability information on the map
 by coloring each street segment with different colors depending on difficulty.
 */
public class HeatmapLayer: ParknavLayer {

    // MARK: - Private properties

    internal var spotType: ParknavRouteOptions.SpotType?
    internal var radius: Int? = ParknavConstans.Layers.radius
    internal var minProb: Double?
    internal var maxProb: Double?
    internal var minLength: Int?
    internal var maxLength: Int?

    /**
     `HeatmapLayer` object initializer

     - parameter destination: Destination location
     - parameter currentLocation: Current user's location
     */
    public required init(destination: CLLocationCoordinate2D, currentLocation: CLLocationCoordinate2D?) {
        super.init(destination: destination, currentLocation: currentLocation)
        self.spotType = ParknavRouteOptions.SpotType.all
        self.radius = 1000
        self.minProb = 0
        self.maxProb = 1
    }

    // MARK: - Public functions

    /**
     Display the layer on the map

     - Parameter mapView: mapView to display the layer on
     - Parameter shapeCollection: object of type MGLShapeCollectionFeature with all the geometric layer info
     */
    public override func displayOnMap(_ mapView: MGLMapView, shapeCollection: MGLShapeCollectionFeature) {
        let polylines = shapeCollection.shapes.map { $0 as? MGLPolylineFeature }.filter { $0 != nil }
        DispatchQueue.main.async {
            if !polylines.isEmpty {
                mapView.addAnnotations(polylines as? [MGLAnnotation] ?? [])
            }
        }
    }
}
