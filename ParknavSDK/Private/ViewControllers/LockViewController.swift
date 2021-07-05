//
//  LockViewController.swift
//  ParknavSDK

import UIKit

class LockViewController: UIViewController {
    @IBOutlet var lockImageView: UIImageView!

    func applyStyle(_ style: StyleColorsScheme?) {
        guard let style = style else {return}
        lockImageView.image = style.lockScreenImage
    }
}
