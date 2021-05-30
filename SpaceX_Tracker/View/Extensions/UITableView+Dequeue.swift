//
//  UITableView+Dequeue.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

extension UITableView {
    func cell<T: ListItemCell>(with item: ListItem, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
}
