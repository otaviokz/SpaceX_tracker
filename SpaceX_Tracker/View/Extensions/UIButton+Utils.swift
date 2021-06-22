//
//  UIButton+Utils.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 10/06/2021.
//

import UIKit

extension UIButton {
    @discardableResult
    func image(_ image: UIImage?) -> Self {
        setImage(image, for: .normal)
        return self
    }
    
    @discardableResult
    func onTap(_ target: Any?, _ action: Selector) -> Self {
        addTarget(target, action: action, for: .touchUpInside)
        return self
    }
}
