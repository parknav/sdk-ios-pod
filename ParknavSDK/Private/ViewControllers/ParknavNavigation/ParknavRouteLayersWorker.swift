//
//  ParknavRouteLayersWorker.swift
//  ParknavSDK

import Foundation
import Mapbox
import CoreLocation
import MapboxDirections
import MapboxNavigation

class ParknavRouteLayersWorker {
    func shape(for routes: [Route], legIndex: Int?) -> MGLShape? {
        guard let firstRoute = routes.first else { return nil }
        guard let congestedRoute = addCongestion(to: firstRoute, legIndex: legIndex) else { return nil }

        var altRoutes: [MGLPolylineFeature] = []

        for route in routes.suffix(from: 1) {
            guard let coordinates = route.coordinates else { continue }
            let polyline = MGLPolylineFeature(coordinates: coordinates, count: UInt(coordinates.count))
            polyline.attributes["isAlternateRoute"] = true
            altRoutes.append(polyline)
        }
        return MGLShapeCollectionFeature(shapes: altRoutes + congestedRoute)
    }

    func addCongestion(to route: Route, legIndex: Int?) -> [MGLPolylineFeature]? {
        guard let coordinates = route.coordinates else { return nil }

        var linesPerLeg: [MGLPolylineFeature] = []
        for (index, leg) in route.legs.enumerated() {
            // If there is no congestion, don't try and add it
            guard let legCongestion = leg.segmentCongestionLevels, legCongestion.count < coordinates.count else {
                return [MGLPolylineFeature(coordinates: coordinates, count: UInt(coordinates.count))]
            }

            // The last coord of the preceding step, is shared with the first coord of the next step, we don't need both.
            let legCoordinates: [CLLocationCoordinate2D] = leg.steps.enumerated().reduce([]) { allCoordinates, current in
                let index = current.offset
                let step = current.element
                let stepCoordinates = step.coordinates ?? []

                return index == 0 ? stepCoordinates : allCoordinates + stepCoordinates.suffix(from: 1)
            }

            let mergedCongestionSegments = combine(legCoordinates, with: legCongestion)

            let lines: [MGLPolylineFeature] =
                mergedCongestionSegments.map { (congestionSegment: ([CLLocationCoordinate2D], CongestionLevel))
                    -> MGLPolylineFeature in
                    let polyline = MGLPolylineFeature(coordinates: congestionSegment.0, count: UInt(congestionSegment.0.count))
                    polyline.attributes[MBCongestionAttribute] = String(describing: congestionSegment.1)
                    polyline.attributes["isAlternateRoute"] = false
                    if let legIndex = legIndex { polyline.attributes[MBCurrentLegAttribute] = index == legIndex
                    } else { polyline.attributes[MBCurrentLegAttribute] = index == 0 }
                    return polyline
            }

            linesPerLeg.append(contentsOf: lines)
        }
        return linesPerLeg
    }

    func combine(_ coordinates: [CLLocationCoordinate2D],
                 with congestions: [CongestionLevel]) -> [([CLLocationCoordinate2D], CongestionLevel)] {
        guard coordinates.count > congestions.count else {return []}
        var segments: [([CLLocationCoordinate2D], CongestionLevel)] = []
        segments.reserveCapacity(congestions.count)
        for (index, congestion) in congestions.enumerated() {
            let congestionSegment: ([CLLocationCoordinate2D], CongestionLevel) =
                ([coordinates[index], coordinates[index + 1]], congestion)
            let coordinates = congestionSegment.0
            let congestionLevel = congestionSegment.1

            if segments.last?.1 == congestionLevel { segments[segments.count - 1].0 += coordinates
            } else { segments.append(congestionSegment) }
        }
        return segments
    }
}
