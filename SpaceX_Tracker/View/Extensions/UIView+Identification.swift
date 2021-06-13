//
//  UIView+Identification.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 13/06/2021.
//

import UIKit

extension UIAccessibilityIdentification {
    @discardableResult
    func identifier(_ identifier: String) -> Self {
        accessibilityIdentifier = identifier
        return self
    }
}
