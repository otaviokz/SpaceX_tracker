//
//  UITableView+Dequeue.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

extension UITableView {
    func cell<T: ListItemCellType>(for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
    
    func seViewModel<T: ListViewModelType>(_ listViewModel: T) {
        delegate = listViewModel
        dataSource = listViewModel
    }
}
