//
//  UIView+Constrainable.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

extension UIView {
    var constrainable: Self {
        setConstrainable()
        return self
    }
    
    func setConstrainable() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @discardableResult
    func adding(_ subview: UIView, padding: CGFloat) -> Self {
        addSubview(subview.constrainable)
        NSLayoutConstraint.activate(subview.constrainTo(self, constant: padding))
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
        leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: constant)
    }
    
    func constrainTrail(to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        trailingAnchor.constraint(equalTo: to.trailingAnchor, constant: -constant.abs)
    }
    
    func constrainTop(to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        topAnchor.constraint(equalTo: to.topAnchor, constant: constant)
    }
    
    func constraintBottom(to: UIView, constant: CGFloat) -> NSLayoutConstraint {
        bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -constant.abs)
    }
}

private extension CGFloat {
    var abs: CGFloat {
        self < 0 ? -self : self
    }
}
