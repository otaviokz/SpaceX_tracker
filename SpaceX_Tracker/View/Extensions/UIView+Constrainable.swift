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
        NSLayoutConstraint.activate(subview.constraintTo(self, constant: padding))
        return self
    }
}

extension UIView {
    func constraintTo(_ to: UIView, constant: CGFloat) -> [NSLayoutConstraint] {
        constraintHorizontal(to: to, constant: constant) + constraintVertical(to: to, constant: constant)
    }
    
    func constraintHorizontal(to: UIView, constant: CGFloat) -> [NSLayoutConstraint] {
        [constraintLead(to: to, constant: constant), constraintTrail(to: to, constant: constant)]
    }
    
    func constraintVertical(to: UIView, constant: CGFloat) -> [NSLayoutConstraint] {
        [constraintTop(to: to, constant: constant), constraintBottom(to: to, constant: constant)]
    }
    
    func constraintLead(to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard constant >= 0 else { fatalError("Requires a positive constant") }
        return leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: constant)
    }
    
    func constraintTrail(to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard constant >= 0 else { fatalError("Requires a positive constant") }
        return trailingAnchor.constraint(equalTo: to.trailingAnchor, constant: -constant.abs)
    }
    
    func constraintTop(to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard constant >= 0 else { fatalError("Requires a positive constant") }
        return topAnchor.constraint(equalTo: to.topAnchor, constant: constant)
    }
    
    func constraintBottom(to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard constant >= 0 else { fatalError("Requires a positive constant") }
        return bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -constant.abs)
    }
}

