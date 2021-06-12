//
//  UILabel+Styling.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

extension UILabel {
    @discardableResult
    func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    convenience init(_ text: String? = nil) {
        self.init()
        self.text = text
    }
    
    @discardableResult
    func numberOfLines(_ number: Int) -> Self {
        numberOfLines = number
        return self
    }
}
