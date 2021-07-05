//
//  DirectionsResponseExtension.swift
//  ParknavSDK
//

import Foundation
import Mapbox
import MapboxDirections
import MapboxCoreNavigation

// MARK: - ResponseObjectSerializable, JSONSerializable

extension DirectionsResponse: ResponseObjectSerializable, JSONSerializable {
    init?(response: HTTPURLResponse, representation: Any) {
        guard let representation = representation as? [String: Any] else { return nil }
        code = representation["code"] as? String ?? ""
        uuid = representation["uuid"] as? String ?? ""
        if let waypointsJSON = representation["waypoints"] as? [[String: Any]] { parseWaipoints(waypointsJSON) }
        if let routesJSON = representation["routes"] as? [[String: Any]] { parseRoutes(routesJSON) }
    }

    init?(json: [String: Any]?) {
        guard let json = json else { return nil }
        code = json["code"] as? String ?? ""
        uuid = json["uuid"] as? String ?? ""
        if let waypointsJSON = json["waypoints"] as? [[String: Any]] { parseWaipoints(waypointsJSON) }
        if let routesJSON = json["routes"] as? [[String: Any]] { parseRoutes(routesJSON) }
    }
}

extension DirectionsResponse {
    mutating func parseWaipoints(_ waypointsJSON: [[String: Any]]) {
        waypoints = waypointsJSON.map { json in
            let location = json["location"] as? [Double] ?? []
            let coordinate = CLLocationCoordinate2D(geoJSON: location)
            let name = json["name"] as? String ?? ""
            return Waypoint(coordinate: coordinate, name: name)
        }
    }

    mutating func parseRoutes(_ routesJSON: [[String: Any]]) {
        guard waypoints.count > 1 else {return}
//        let decoder = ParknavConstans.Coding.decoder
        let routeOptions = NavigationRouteOptions(waypoints: waypoints)
        routeOptions.locale = Locale(identifier: ParknavRouteOptions.instance.localeID)
        routeOptions.distanceMeasurementSystem = .metric
        routes = routesJSON.compactMap { json in
            if let routeOptionsJSON = json["routeOptions"] as? [String: Any] {
                baseURL = routeOptionsJSON["baseUrl"] as? String ?? ""
                if let format = routeOptionsJSON["geometries"] as? String {
                    routeOptions.shapeFormat = RouteShapeFormat(description: format) ?? .polyline6
                }
            }
//            decoder.userInfo[.options] = routeOptions
//            guard let routeData = try? JSONSerialization.data(withJSONObject: json),
//
//                  let route = try? decoder.decode(Route.self, from: routeData) else {
//                return nil
//            }
            let route = Route(json: json, waypoints: self.waypoints, options: routeOptions)
            route.speechLocale = routeOptions.locale
            return route
        }
        geometries = routesJSON.map {$0["geometry"] as? String ?? ""}
    }
}
