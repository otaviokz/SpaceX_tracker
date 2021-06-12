//
//  UIView+Constrainable.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

extension CGFloat {
    var abs: CGFloat {
        self < 0 ? -self : self
    }
}

extension UIView {
    var constrainable: Self {
        setConstrainable()
        return self
    }
    
    func setConstrainable() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @discardableResult
    func accessibilityIdentifier(_ identifier: String) -> Self {
        accessibilityIdentifier = identifier
        return self
    }
    
    @discardableResult
    func add(_ subview: UIView, padding: CGFloat) -> Self {
        addSubview(subview.constrainable)
        NSLayoutConstraint.activate(subview.constrainTo(self, constant: padding))
        return self
    }
    
    @discardableResult
    func add(_ subview: UIView, horizontalPadding: CGFloat = 0, verticalPadding: CGFloat = 0) -> Self {
        addSubview(subview.constrainable)
        NSLayoutConstraint.activate(
            subview.constrainHorizontal(to: self, constant: horizontalPadding) +
            subview.constrainVertical(to: self, constant: verticalPadding)
        )
        return self
    }
}

extension UIView {
    func constrainTo(_ to: UIView, constant: CGFloat) -> [NSLayoutConstraint] {
        constrainHorizontal(to: to, constant: constant) + constrainVertical(to: to, constant: constant)
    }
    
    func constrainHorizontal(to: UIView, constant: CGFloat) -> [NSLayoutConstraint] {
        [constrainLead(to: to, constant: constant), constrainTrail(to: to, constant: constant)]
    }
    
    func constrainVertical(to: UIView, constant: CGFloat) -> [NSLayoutConstraint] {
        [constrainTop(to: to, constant: constant), constraintBottom(to: to, constant: constant)]
    }
    
    func constrainLead(to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard constant >= 0 else { fatalError("Requires a positive constant") }
        return leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: constant)
    }
    
    func constrainTrail(to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard constant >= 0 else { fatalError("Requires a positive constant") }
        return trailingAnchor.constraint(equalTo: to.trailingAnchor, constant: -constant.abs)
    }
    
    func constrainTop(to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard constant >= 0 else { fatalError("Requires a positive constant") }
        return topAnchor.constraint(equalTo: to.topAnchor, constant: constant)
    }
    
    func constraintBottom(to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard constant >= 0 else { fatalError("Requires a positive constant") }
        return bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -constant.abs)
    }
}

