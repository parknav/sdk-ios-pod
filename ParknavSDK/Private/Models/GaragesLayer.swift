//
//  GaragesLayer.swift
//  ParknavSDK

import UIKit
import CoreLocation
import Mapbox

class GaragesLayer: ParknavLayer {
    // MARK: - Private properties

    internal var radius: Int?
    internal var garagesOnParkingRoute: Bool = false
    internal var routeGeometry: String?

    // MARK: - Public functions

    public override func displayOnMap(_ mapView: MGLMapView, shapeCollection: MGLShapeCollectionFeature) {
        let garages = shapeCollection.shapes.map { $0 as? MGLPointFeature }.filter { $0 != nil }
        DispatchQueue.main.async {
            if !garages.isEmpty { mapView.addAnnotations(garages as? [MGLAnnotation] ?? []) }
        }
    }

    static func address(_ annotation: MGLPointFeature) -> String { annotation.attribute(forKey: "address") as? String ?? "" }

    static func price(_ annotation: MGLPointFeature) -> Double { annotation.attribute(forKey: "price") as? Double ?? 0 }

    static func formattedPrice(_ annotation: MGLPointFeature) -> String {
        annotation.attribute(forKey: "formattedPrice") as? String ?? "" }

    static func name(_ annotation: MGLPointFeature) -> String { annotation.attribute(forKey: "name") as? String ?? "" }

    static func spots(_ annotation: MGLPointFeature) -> Int { annotation.attribute(forKey: "spots") as? Int ?? 0 }

    static func dynamic(_ annotation: MGLPointFeature) -> Bool { annotation.attribute(forKey: "dynamic") as? Bool ?? true }

    static func icon(_ annotation: MGLPointFeature) -> MGLAnnotationImage? {
        let garagePrice = price(annotation)
        let fPrice = formattedPrice(annotation)
        let iconName =  garagePrice > 0 ? "pin" : "parkingPin"
        guard let pinImage = UIImage(named: iconName, in: Bundle.mainSDKBundle, compatibleWith: nil) else {return nil}
        return garagePrice > 0 ? renderPriceIcon(UIImageView(image: pinImage), price: fPrice)
            : MGLAnnotationImage(image: pinImage, reuseIdentifier: "parkingPin")
    }
}
