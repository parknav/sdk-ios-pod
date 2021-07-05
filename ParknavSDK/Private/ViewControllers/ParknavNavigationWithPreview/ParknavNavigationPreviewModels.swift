//
//  ParknavNavigationPreviewModels.swift
//  ParknavSDK
//

import UIKit
import MapboxNavigation

enum ParknavNavigationPreview {
    // swiftlint:disable nesting
    enum Arrival {
        struct Response {
            var expectedTime: TimeInterval
            var expectedDistance: Double
        }
        struct ViewModel {
            var expectedTime: String
            var expectedDistance: String
        }
    }

    enum MapStyle {
        struct Response {
            var style: Style
        }
        struct ViewModel {
            var style: Style
        }
    }

    enum Garage {
        struct Response {
            var garage: MGLPointFeature
        }
        struct ViewModel {
            var address: String
            var name: String
            var price: String
        }
    }
    // swiftlint:enable nesting
}
