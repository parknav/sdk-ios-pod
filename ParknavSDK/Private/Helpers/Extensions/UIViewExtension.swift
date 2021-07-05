//
//  UIViewExtension.swift
//  Alamofire

import UIKit

extension UIView {

    func loadViewFromNib(with classToLoad: AnyClass) {
        let bundle = Bundle(for: classToLoad)
        let nib = UINib(nibName: String(describing: classToLoad), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }

    func applyDefaultCornerRadiusShadow(cornerRadius: CGFloat? = 4, shadowOpacity: CGFloat? = 0.1) {
        layer.cornerRadius = cornerRadius!
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 4
        layer.shadowOpacity = Float(shadowOpacity!)
    }

    var safeArea: UIEdgeInsets {
        guard #available(iOS 11.0, *) else { return .zero }
        return safeAreaInsets
    }

    func findSubview<T: UIView>(_ subviewClass: T.Type) -> T? {
        let subviewsOfClass = subviews.filter { $0.classForCoder == subviewClass }
        return subviewsOfClass.isEmpty ? nil : subviewsOfClass.first as? T
    }

    func findConstraint(with firstItemClass: AnyClass,
                        firstAttribute: NSLayoutConstraint.Attribute,
                        relation: NSLayoutConstraint.Relation, secondItemClass: AnyClass,
                        secondAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        let filteredConstraints = constraints.filter { constraint -> Bool in
            return constraint.firstItem?.classForCoder == firstItemClass &&
                    constraint.firstAttribute == firstAttribute &&
            constraint.secondItem?.classForCoder == secondItemClass &&
            constraint.secondAttribute == secondAttribute &&
            constraint.relation == relation
        }
        return filteredConstraints.isEmpty ? nil : filteredConstraints.first
    }
}
