//
//  ParknavLayerExtension.swift
//  ParknavSDK
//

import Foundation
import CoreLocation

@objc extension ParknavLayer {
    var name: String { "\(self)" }

    var userId: String {
        _ = UserDefaultsService.service.loadFromUserDefaults()
        if let userID = UserDefaultsService.service.userId { return userID }
        let userID = UUID().uuidString
        UserDefaultsService.service.userId = userID
        _ = UserDefaultsService.service.saveToUserDefaults()
        return userID
    }

    var clientInfo: String { ParknavConstans.API.clientInfoPart + Bundle.versionString }

    var path: String { "" }
    var parameters: [String: Any] {
        var params: [String: Any] = [
            "destination": "\(destination.latitude),\(destination.longitude)",
            "clientInfo": clientInfo,
            "userId": userId,
            "sdkVersion": ParknavConstans.API.SDKVersion,
            "platform": "ios"]
        if let currentLocation = currentLocation {
            params["currentLocation"] = "\(currentLocation.latitude),\(currentLocation.longitude)" }
        return params
    }

    var baseURL: String { ParknavServiceHelper.instance.getServiceEndpointInfo(destination).URL }

    var apiKey: String { ParknavServiceHelper.instance.getServiceEndpointInfo(destination).APIKey }

}
