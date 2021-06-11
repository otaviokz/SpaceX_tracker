//
//  UIBarButtonItem+Styling.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 10/06/2021.
//

import UIKit

extension UIBarButtonItem {
    @discardableResult
    @objc func identifier(_ identifier: String) -> Self {
        accessibilityIdentifier = identifier
        return self
    }
}
