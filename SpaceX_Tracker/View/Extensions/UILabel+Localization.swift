//
//  UILabel+Localization.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

extension UILabel {
    convenience init(key: LocalizationKey) {
        self.init()
        text = localize(key)
    }
}
