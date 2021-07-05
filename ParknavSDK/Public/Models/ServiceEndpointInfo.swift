//
//  ServiceEndpointInfo.swift
//  ParknavSDK
//

import Foundation

/**
 Base URL and APIkey for using the ParknavSDK
 */
public struct ServiceEndpointInfo {
    var URL: String { initialURL.formatURL(to: ParknavConstans.API.fixedPartOfURL) + "/" }
    var APIKey: String

    internal var initialURL: String

    public init(URL: String, APIKey: String) {
        self.initialURL = URL
        self.APIKey = APIKey
    }
}
