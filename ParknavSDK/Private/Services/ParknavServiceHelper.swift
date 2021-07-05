//
//  ParknavServiceHelper.swift
//  ParknavSDK
//

import Foundation
import CoreLocation

class ParknavServiceHelper {
    static var instance = ParknavServiceHelper()
    var serverInfo: ServerInfo?

    func getServiceEndpointInfo(_ currentLocation: CLLocationCoordinate2D) -> ServiceEndpointInfo {
        serverInfo?(currentLocation) ?? ServiceEndpointInfo(URL: "", APIKey: "")
    }
}
