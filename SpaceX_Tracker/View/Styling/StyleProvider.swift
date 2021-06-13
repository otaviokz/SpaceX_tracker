//
//  StyleProvider.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 11/06/2021.
//

import UIKit

struct Style {
    struct Image {
        static let checkmark = UIImage(named: "checkmark")
        static let badgePlaceholder = UIImage(named: "badge_placeholder")
        static let success = UIImage(named: "success")
        static let failure = UIImage(named: "failure")
        static let filter = UIImage(named: "filter")
        static let sort = UIImage(named: "sort")
    }
    
    enum Color {
        case barbutton
        case checkbox
        case solidBlack
        
        var color: UIColor {
            switch self {
            case .barbutton:
                return .black.withAlphaComponent(0.8)
            case .checkbox:
                return .black.withAlphaComponent(0.7)
            case .solidBlack:
                return .black
            }
        }
    }
    
    enum Font {
        case body
        case grayBody
        case header
        
        var font: UIFont {
            switch self {
            case .body, .grayBody:
                return .systemFont(ofSize: 17, weight: .regular)
            case .header:
                return .systemFont(ofSize: 17, weight: .medium)
            }
        }
        
        var color: UIColor {
            switch self {
            case .body:
                return .black
            case .grayBody:
                return .gray
            case .header:
                return .white
            }
        }
    }
}
