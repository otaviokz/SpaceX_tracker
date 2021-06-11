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
}
