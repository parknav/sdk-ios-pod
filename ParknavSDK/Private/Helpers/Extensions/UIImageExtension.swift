//
//  UIImageExtension.swift
//  ParknavSDK
//

import UIKit

extension UIImage {
    static func imageWithColor(_ color: UIColor) -> UIImage {
        let pixelScale = UIScreen.main.scale
        let pixelSize = 1 / pixelScale
        let fillSize = CGSize(width: pixelSize, height: pixelSize)
        let fillRect = CGRect(origin: CGPoint.zero, size: fillSize)
        UIGraphicsBeginImageContextWithOptions(fillRect.size, false, pixelScale)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext!.setFillColor(color.cgColor)
        graphicsContext!.fill(fillRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    static func imageWithView(_ view: UIView) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let renderedImage = renderer.image { _ in view.drawHierarchy(in: view.bounds, afterScreenUpdates: true) }
        return renderedImage
    }
}
