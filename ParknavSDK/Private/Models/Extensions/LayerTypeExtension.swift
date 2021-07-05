//
//  LayerTypeExtension.swift
//  ParknavSDK
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
