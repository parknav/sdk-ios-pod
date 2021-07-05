//
//  LayerRulesExtension.swift
//  ParknavSDK
//
//  Created by Ekaterina Kharlamova on 02/06/2021.
//  Copyright © 2021 AI Incube. All rights reserved.
//

import Foundation

extension LayerRules {
    func configureLayer<T: ParknavLayer>(_ layerType: T.Type) -> T? {
        destination == nil ? nil : layerType.init(destination: destination!, currentLocation: userLocation?.coordinate)
    }
}
