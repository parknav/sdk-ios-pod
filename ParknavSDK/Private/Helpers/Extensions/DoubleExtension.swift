//
//  DoubleExtension.swift
//  Alamofire

import UIKit

extension Double {
    var probailityColor: UIColor {
        switch self {
        case 0.nextDown...0: return UIColor.black
        case 0.nextUp...0.4: return #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        case 0.4.nextUp...0.8: return #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        case 0.8.nextUp...1: return #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        default:
            return UIColor.clear
        }
    }

    var string: String { String(format: "%g", self) }
}
