//
//  GaragesLayerExtension.swift
//  ParknavSDK
//

import Foundation
import CoreLocation
import Mapbox

extension GaragesLayer {
    override var path: String { ParknavConstans.API.Endpoints.garages }

    override var parameters: [String: Any] {
        var params = super.parameters
        params["radius"] = radius ?? (garagesOnParkingRoute
                                        ? ParknavConstans.Layers.garageRadiusOnParkingRoute
                                        : ParknavConstans.Layers.radius)
        if let polyline = routeGeometry { params["polyline"] = polyline }
        return params
    }

    static func renderPriceIcon(_ imageView: UIImageView, price: String) -> MGLAnnotationImage? {
        let view = UIView(frame: imageView.frame)
        view.backgroundColor = .clear
        view.addSubview(imageView)
        let label = UILabel(frame: imageView.frame)
        label.text = price
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        view.addSubview(label)
        // Put the label at the center of the 'top square' of the pin.
        label.center = CGPoint(x: view.bounds.width/2, y: view.bounds.width/2)
        label.frame = label.frame.integral
        guard let renderedImage = UIImage.imageWithView(view) else {return nil}
        return MGLAnnotationImage(image: renderedImage, reuseIdentifier: "pin-" + price)
    }
}
