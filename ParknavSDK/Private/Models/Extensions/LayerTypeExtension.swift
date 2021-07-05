//
//  LayerTypeExtension.swift
//  ParknavSDK
//
//  Created by Ekaterina Kharlamova on 24/06/2021.
//  Copyright © 2021 AI Incube. All rights reserved.
//

import Foundation

extension LayerType {
    var type: ParknavLayer.Type {
        switch self {
        case .heatmap: return HeatmapLayer.self
        case .bestArea: return BestAreaLayer.self
        case .garages: return GaragesLayer.self          }
    }
}
