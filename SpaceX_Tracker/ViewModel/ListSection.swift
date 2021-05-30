//
//  ListSection.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import Foundation

protocol ListSectionTyoe {
    var title: String { get }
    var items: [ListItem] { get }
}


struct ListSection: ListSectionTyoe {
    let title: String
    let items: [ListItem]
}
