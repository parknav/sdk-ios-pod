//
//  RouteMessage.swift
//  ParknavSDK

import UIKit

struct RouteMessage {
    // swiftlint:disable identifier_name
    enum MessageType: String {
        case preview
        case preview_low
        case preview_high
        case preview_medium

        var image: UIImage? { UIImage(named: self.rawValue, in: Bundle.mainSDKBundle, compatibleWith: nil) }
    }
    // swiftlint:enable identifier_name

    var message: String = ""
    var value: Double = 0
    var type: String = "preview"
    var color: UIColor = #colorLiteral(red: 0.9176470588, green: 0.1647058824, blue: 0.5294117647, alpha: 1)

    init?(jsonString: String) {
        guard let json = jsonString.dictionary else {
            return nil
        }
        self.message = json["message"] as? String ?? ""
        self.value = json["value"] as? Double ?? 0
        self.type = json["type"] as? String ?? "preview"
        guard let colorString = json["color"] as? String else {return}
        self.color = colorString.color
    }
}
