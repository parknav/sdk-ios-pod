//
//  GeoJSON.swift
//  ParknavSDK

import Foundation

struct GeoJSON: JSONSerializable, ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: Any) {}

    init?(json: [String: Any]?) {}
}
