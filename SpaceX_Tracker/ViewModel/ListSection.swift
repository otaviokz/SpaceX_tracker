//
//  ListSection.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import Foundation

struct ListSection {
    let title: String
    let items: [ListItemType]
    
    init(key: LocalizationKey, items: [ListItemType]) {
        self.title = localize(key)
        self.items = items
    }
}
