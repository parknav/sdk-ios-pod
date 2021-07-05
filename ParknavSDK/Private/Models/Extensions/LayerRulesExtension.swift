//
//  LayerRulesExtension.swift
//  ParknavSDK
//

import Foundation

extension LayerRules {
    func configureLayer<T: ParknavLayer>(_ layerType: T.Type) -> T? {
        destination == nil ? nil : layerType.init(destination: destination!, currentLocation: userLocation?.coordinate)
    }
}
