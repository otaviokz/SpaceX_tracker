//
//  UIView+Styling.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

extension UIView {
    @discardableResult
    func background(_ color: Style.Color) -> Self {
        backgroundColor = color.color
        return self
    }
    
    @discardableResult
    func tint(_ color: Style.Color) -> Self {
        tintColor = color.color
        return self
    }
}
