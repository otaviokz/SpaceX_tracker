//
//  UILabel+Styling.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

extension UILabel {
    convenience init(_ text: String? = nil) {
        self.init()
        self.text = text
    }
    
    @discardableResult
    func numberOfLines(_ number: Int) -> Self {
        numberOfLines = number
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    @discardableResult
    func font(_ font: Style.Font) -> Self {
        self.font = font.font
        textColor = font.color
        return self
    }
    
    static func header(_ text: String? = nil) -> UILabel {
        UILabel(text).font(.header).multiline
    }
    
    static func body(_ text: String? = nil) -> UILabel {
        UILabel(text).font(.body).multiline
    }
    
    static func grayBody(_ text: String? = nil) -> UILabel {
        UILabel(text).font(.grayBody).multiline
    }
    
    var multiline: UILabel {
        numberOfLines(0).constrainable
    }
}
