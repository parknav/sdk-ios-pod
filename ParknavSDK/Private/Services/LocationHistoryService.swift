//
//  LocationHistoryService.swift
//  ParknavSDK
//

import Foundation
import CoreLocation

class LocationHistoryService {

    // MARK: - Static properties

    internal static let instance = LocationHistoryService(parknavOptions: ParknavRouteOptions.instance)

    // MARK: - Public properties

    internal var locationsHistory = [CLLocation]()

    internal var currentAngle: Double {
        guard locationsHistory.count > 1 else {return -1}
        let lastLocation = locationsHistory.last!
        let secondLocation = locationsHistory.first { location -> Bool in
            location.distance(from: lastLocation) >= Double(ParknavConstans.Location.minDistanceToCalculateAngle)
        }
        guard let previousLocation = secondLocation else {return -1}
        return previousLocation.coordinate.angle(with: lastLocation.coordinate)
    }

    internal var lastDetectedLocation: CLLocation? { locationsHistory.last }

    internal var lastResponseBaseURL = ""

    // MARK: - Private properties

    private var parknavOptions: ParknavRouteOptions

    // MARK: - Public functions

    internal init(parknavOptions: ParknavRouteOptions) {
        self.parknavOptions = parknavOptions
    }

    internal func addLocation(_ location: CLLocation) {
        updateParknavOptions(location)
        locationsHistory.append(location)
        if locationsHistory.count > ParknavConstans.Location.locationsHistoryLength {
            locationsHistory.remove(at: 0) }
        locationsHistory.sort { (location1, location2) -> Bool in
            location1.timestamp.timeIntervalSince1970 < location2.timestamp.timeIntervalSince1970
        }
    }

    // MARK: - Private functions

    private func updateParknavOptions(_ location: CLLocation) {
        if let destination = parknavOptions.destination {
            if location.coordinate.distance(from: destination) < parknavOptions.destinationReachedThreshold {
                parknavOptions.navigateToDestination = false
            }
        } else {
            parknavOptions.destination = location.coordinate
        }
    }
}
