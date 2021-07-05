//
//  GarageExtension.swift
//  ParknavSDK
//

import Foundation
import CoreLocation

extension Garage: ResponseObjectSerializable, ResponseCollectionSerializable {
    init?(response: HTTPURLResponse, representation: Any) {
        guard let representation = representation as? [String: Any] else { return nil }
        name = representation["name"] as? String ?? ""
        let geometryJSON = representation["geometry"] as? [Double] ?? []
        geometry = CLLocationCoordinate2D(geoJSON: geometryJSON)
        address = representation["address"] as? String ?? ""
        distance = representation["distance"] as? Double ?? 0
        garageId = representation["garageId"] as? String ?? ""
        city = representation["city"] as? String ?? ""
        spots = representation["spots"] as? Int ?? 0
        dynamic = representation["dynamic"] as? Bool ?? true
        price = representation["price"] as? Double ?? 0
    }
}

extension Garage: JSONSerializable, JSONCollectionSerializable {
    init?(json: [String: Any]?) {
        guard let json = json else { return nil }
        name = json["name"] as? String ?? ""
        let geometryJSON = json["geometry"] as? [Double] ?? []
        geometry = CLLocationCoordinate2D(geoJSON: geometryJSON)
        address = json["address"] as? String ?? ""
        distance = json["distance"] as? Double ?? 0
        garageId = json["garageId"] as? String ?? ""
        city = json["city"] as? String ?? ""
        spots = json["spots"] as? Int ?? 0
        dynamic = json["dynamic"] as? Bool ?? true
        price = json["price"] as? Double ?? 0
    }
}
