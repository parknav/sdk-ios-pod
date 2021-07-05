//
//  RouteExtension.swift
//  ParknavSDK

import Foundation
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

extension Route {
    var routeMessage: RouteMessage? {
        let routeMessages = legs.compactMap { $0.name }
            .compactMap { name -> String? in
                // Skip over the actual leg name to get to our meta-data.
                // Example:
                // "Stret A, Street B,{\"message\":\"...\",\"value\":35.0 ... }"
                name.firstIndex(of: "{")
                    .map { name.suffix(from: $0) }
                    .map { String($0) }
            }.compactMap { RouteMessage(jsonString: $0) }
        return !routeMessages.isEmpty ? routeMessages.first : nil
    }

    var parkingMessage: String? {
        let firstSteps = legs.compactMap { $0.steps.first }
        return firstSteps.last?.instructionsSpokenAlongStep?.first?.text
    }
}
