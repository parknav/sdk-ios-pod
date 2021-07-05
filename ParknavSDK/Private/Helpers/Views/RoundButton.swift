//
//  RoundButton.swift
//  ParknavSDK

import UIKit

class RoundButton: UIButton {

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = bounds.height * 0.5
        layer.masksToBounds = true
        super.draw(rect)
    }

}
