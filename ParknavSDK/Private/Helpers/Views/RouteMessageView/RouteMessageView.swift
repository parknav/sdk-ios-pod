//
//  RouteMessageView.swift
//  ParknavSDK

import UIKit

class RouteMessageView: UIView {

    @IBOutlet var routeMessageLabel: UILabel!
    @IBOutlet var routeMessageImageView: UIImageView!

    var messageText: String = "" {
        didSet {
            routeMessageLabel.text = messageText
        }
    }

    var messageImage: UIImage? {
        didSet {
            routeMessageImageView.image = messageImage
        }
    }

    var messageColor: UIColor? {
        didSet {
            backgroundColor = messageColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib(with: RouteMessageView.self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib(with: RouteMessageView.self)
    }

}
