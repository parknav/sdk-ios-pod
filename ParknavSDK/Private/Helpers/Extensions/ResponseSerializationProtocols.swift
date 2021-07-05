//
//  ResponseSerializationProtocols.swift
//  ParknavSDK
//

import Foundation
import Alamofire

protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: Any)
}

protocol ResponseCollectionSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self]
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self] {
        var collection: [Self] = []

        if let representation = representation as? [[String: Any]] {
            for itemRepresentation in representation {
                if let item = Self(response: response, representation: itemRepresentation) {
                    collection.append(item)
                }
            }
        }
        return collection
    }
}

protocol JSONSerializable {
    init?(json: [String: Any]?)
}

protocol JSONCollectionSerializable {
    static func collection(from JSONArray: [[String: Any]]?) -> [Self]
}

extension JSONCollectionSerializable where Self: JSONSerializable {
    static func collection(from JSONArray: [[String: Any]]?) -> [Self] {
        var collection: [Self] = []
        if let JSONArray = JSONArray {
            for JSONObject in JSONArray {
                if let item = Self(json: JSONObject) {
                    collection.append(item)
                }
            }
        }
        return collection
    }
}
