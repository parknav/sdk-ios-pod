//
//  ParkingMenuView.swift
//  ParknavSDK

import UIKit

@objc
protocol ParkingMenuViewDelegate {
    func didTouchNavigationButton()
}

class ParkingMenuView: UIView {

    // MARK: - Outlets

    @IBOutlet var blockView: UIView!
    @IBOutlet var navigationButton: UIButton!
    @IBOutlet var actionButton: UIButton!

    @IBOutlet weak var delegate: ParkingMenuViewDelegate?

    // MARK: - View lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib(with: ParkingMenuView.self)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib(with: ParkingMenuView.self)
    }

    override func point(inside point: CGPoint, with  event: UIEvent?) -> Bool {
        guard let view = subviews.first else {return false}
        for subview in view.subviews as [UIView] {
            if !subview.isHidden && subview.alpha > 0 &&
                subview.isUserInteractionEnabled &&
                subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }

    // MARK: - Private functions

    private func configureViews(areActionsShown: Bool) {
        actionButton.isSelected = areActionsShown
        blockView.isHidden = !actionButton.isSelected
        navigationButton.isHidden = !actionButton.isSelected
    }

    // MARK: - Touch events

    @IBAction func actionButtonTouch(_ sender: UIButton) {
        configureViews(areActionsShown: !sender.isSelected)
    }

    @IBAction func navigationButtonTouch(_ sender: UIButton) {
        configureViews(areActionsShown: false)
        delegate?.didTouchNavigationButton()
    }
}
