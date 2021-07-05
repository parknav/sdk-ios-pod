//
//  BestAreaLayerExtension.swift
//  ParknavSDK
//

import Foundation
import CoreLocation

extension BestAreaLayer {
    override var path: String { ParknavConstans.API.Endpoints.bestArea }

    override var parameters: [String: Any] {
        var params = super.parameters
        if let radius = radius { params["radius"] = radius }
        if let minSize = minSize { params["minSize"] = minSize }
        if let maxSize = maxSize { params["maxSize"] = maxSize }
        if let numAreas = numAreas { params["numAreas"] = numAreas }
        return params
    }

    convenience init(destination: CLLocationCoordinate2D,
                     currentLocation: CLLocationCoordinate2D?,
                     radius: Int?,
                     minSize: Int?,
                     maxSize: Int?,
                     numAreas: Int?) {
        self.init(destination: destination, currentLocation: currentLocation)
        self.radius = radius
        self.minSize = minSize
        self.maxSize = maxSize
        self.numAreas = numAreas
    }
}
