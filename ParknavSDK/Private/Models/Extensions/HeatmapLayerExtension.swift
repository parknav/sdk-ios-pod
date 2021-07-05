//
//  HeatmapLayerExtension.swift
//  ParknavSDK
//

import Foundation
import CoreLocation

extension HeatmapLayer {
    override var path: String { ParknavConstans.API.Endpoints.heatmap }

    override var parameters: [String: Any] {
        var params = super.parameters
        params["outputFormat"] = ParknavRouteOptions.OutputFormat.geojson
        if let spotType = spotType { params["spotType"] = spotType.rawValue }
        if let radius = radius { params["radius"] = radius }
        if let minProb = minProb { params["minProb"] = minProb }
        if let maxProb = maxProb { params["maxProb"] = maxProb }
        if let minLength = minLength { params["minLength"] = minLength }
        if let maxLength = maxLength { params["maxLength"] = maxLength }
        return params
    }

    convenience init(destination: CLLocationCoordinate2D,
                     currentLocation: CLLocationCoordinate2D?,
                     spotType: ParknavRouteOptions.SpotType? = ParknavRouteOptions.SpotType.all,
                     radius: Int? = 1000,
                     minProb: Double? = 0,
                     maxProb: Double? = 1,
                     minLength: Int? = nil,
                     maxLength: Int? = nil) {
        self.init(destination: destination, currentLocation: currentLocation)
        self.spotType = spotType
        self.radius = radius
        self.minProb = minProb
        self.maxProb = maxProb
        self.minLength = minLength
        self.maxLength = maxLength
    }
}
