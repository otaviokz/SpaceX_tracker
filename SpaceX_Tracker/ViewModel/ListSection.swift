//
//  ListSection.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import Foundation

protocol ListSectionType {
    var title: String { get }
    var items: [ListItem] { get }
}


struct ListSection: ListSectionType {
    let title: String
    let items: [ListItem]
}
