//
//  UIView+Constrainable.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

extension UIView {    
    var constrainable: Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func add(_ subview: UIView) -> Self {
        addSubview(subview)
        return self
    }
    
    @discardableResult
    func add(_ views: [UIView]) -> Self {
        views.forEach { addSubview($0) }
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
        NSLayoutConstraint.activate([trailingAnchor.constraint(equalTo: to.trailingAnchor, constant: -constant)])
    }
    
    func constrainTop(to: UIView, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: to.topAnchor, constant: constant)])
    }
    
    func constraintBottom(to: UIView, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -constant)])
    }
}

extension Array where Element == UIView {
    var constrainable: [UIView] { map { $0.constrainable } }
}

@propertyWrapper
struct CGCFloat {
    private var value: CGFloat
    init(_ value: CGFloat = 0) { self.value = max(value, -value) }
    
    var wrappedValue: CGFloat {
        get { value }
        set { value = max(newValue, -newValue) }
    }
    
    var positive: CGFloat {
        wrappedValue
    }
    
    var negative: CGFloat {
        -wrappedValue
    }
}
