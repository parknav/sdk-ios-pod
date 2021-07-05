//
//  RouteTypeView.swift
//  ParknavSDK

import UIKit

class RouteTypeView: UIImageView {
    init() {
        super.init(image: RouteType.parking.image, highlightedImage: RouteType.destination.image)
        applyDefaultCornerRadiusShadow()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(image: RouteType.destination.image, highlightedImage: RouteType.parking.image)
        applyDefaultCornerRadiusShadow()
    }

    func changeRouteType(_ isDestination: Bool) {
        isHighlighted = isDestination
    }
}
