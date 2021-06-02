//
//  UIView+Styling.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

extension UIView {
    @discardableResult
    func background(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
}