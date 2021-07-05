//
//  ServiceEndpointInfo.swift
//  ParknavSDK
//
//  Created by Ekaterina Kharlamova on 02/06/2021.
//  Copyright © 2021 AI Incube. All rights reserved.
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
