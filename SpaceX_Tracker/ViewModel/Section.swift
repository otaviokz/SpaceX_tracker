//
//  ListSection.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import Foundation

struct Section {
    let title: String
    let items: [ItemType]
    
    init(_ key: LocalizationKey, items: [ItemType]) {
        self.title = localize(key)
        self.items = items
    }
}
