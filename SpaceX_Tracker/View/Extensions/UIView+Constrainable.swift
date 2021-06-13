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
    func addConstrainable(_ subview: UIView) -> Self {
        addSubview(subview.constrainable)
        return self
    }
    
    @discardableResult
    func addConstrainable(_ views: [UIView]) -> Self {
        views.forEach { addConstrainable($0) }
        return self
    }
}

extension UIView {
    func constrainTo(_ to: UIView, constant: CGFloat = 0) {
        constrainHorizontal(to: to, constant: constant)
        constrainVertical(to: to, constant: constant)
    }
    
    func constrainHorizontal(to: UIView, constant: CGFloat = 0){
        constrainLead(to: to, constant: constant)
        constrainTrail(to: to, constant: constant)
    }
    
    func constrainVertical(to: UIView, constant: CGFloat = 0) {
        constrainTop(to: to, constant: constant)
        constraintBottom(to: to, constant: constant)
    }
    
    func constrainLead(to: UIView, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: constant)])
    }
    
    func constrainTrail(to: UIView, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([trailingAnchor.constraint(equalTo: to.trailingAnchor, constant: -constant.abs)])
    }
    
    func constrainTop(to: UIView, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: to.topAnchor, constant: constant)])
    }
    
    func constraintBottom(to: UIView, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -constant.abs)])
    }
}

private extension CGFloat {
    var abs: CGFloat {
        self < 0 ? -self : self
    }
}
