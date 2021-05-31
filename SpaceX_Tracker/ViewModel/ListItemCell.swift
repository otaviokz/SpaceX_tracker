//
//  ListItemCell.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

import UIKit

protocol ListItem {}

protocol ListItemCell: UITableViewCell {
    associatedtype ItemType
    static var reuseIdentifier: String { get }
    @discardableResult
    func configure(for item: ItemType) -> Self
}

extension ListItemCell {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

