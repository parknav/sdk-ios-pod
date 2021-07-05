//
//  CLLocationExtension.swift
//  ParknavSDK
//

import Foundation
import CoreLocation

extension CLLocation {
    var isActualLocation: Bool {
        abs(timestamp.timeIntervalSinceNow) <= ParknavConstans.Location.locationActualityTimeinterval &&
            abs(verticalAccuracy) <= ParknavConstans.Location.loactionActualityAccuracy &&
            abs(horizontalAccuracy) <= ParknavConstans.Location.loactionActualityAccuracy
    }

    func isWithinAccuracyInterval(from secondLocation: CLLocation?) -> Bool {
        guard let secondLocation = secondLocation else { return false }
        return distance(from: secondLocation) <= ParknavConstans.Location.loactionActualityAccuracy
    }
}

extension CLLocationCoordinate2D {
    init(geoJSON array: [Double]) {
        assert(array.count == 2)
        self.init(latitude: array[1], longitude: array[0])
    }

    // swiftlint:disable identifier_name
    func angle(with secondLocation: CLLocationCoordinate2D) -> Double {
        let dx = secondLocation.longitude - longitude
        let dy = secondLocation.latitude - latitude
        let radians = atan2(dy, dx)
        let degrees = radians * 180 / .pi
        return degrees < 0 ? degrees + Double(360) : degrees
    }
    // swiftlint:enable identifier_name

    func distance(from secondCoordinate: CLLocationCoordinate2D) -> Double {
        let firstLocation = CLLocation(latitude: latitude, longitude: longitude)
        let secondLocation = CLLocation(latitude: secondCoordinate.latitude, longitude: secondCoordinate.longitude)
        return firstLocation.distance(from: secondLocation)
    }

    func isFarFromDestination(_ destination: CLLocationCoordinate2D?, threshold: Double) -> Bool {
        guard let destination = destination else {return false}
        return distance(from: destination) > threshold
    }
}
