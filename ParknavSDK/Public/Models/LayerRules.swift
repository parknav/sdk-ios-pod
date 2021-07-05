//
//  LayerRules.swift
//  ParknavSDK
//

import Foundation
import Mapbox

/**
 `LayerRules` structure used to manage the Parknav layers which should be displayed
 */
public struct LayerRules {
    /**
     Singlton object of `LayerRules`
     */
    public static var instance = LayerRules()
    /**
     Array of enabled layers' types
     */
    public var enabledLayers = [LayerType.heatmap, LayerType.bestArea]
    /**
     The size of time interval between the layers update (in seconds)
     */
    public var updateTime: TimeInterval = ParknavConstans.Layers.updateTime
    /**
     Destination to create the layer around
     */
    public var destination: CLLocationCoordinate2D?
    /**
     User location to create the layer
     */
    public var userLocation: CLLocation?
}
