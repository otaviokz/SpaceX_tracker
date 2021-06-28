//
//  UITableView+Dequeue.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

extension UITableView {
    func cell<T: ListItemCellType>(for indexPath: IndexPath) -> T? {
        let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T
        return cell?.identifier("\(T.reuseIdentifier)_\(indexPath.section)_\(indexPath.row)")
    }
    
    func setViewModel<T: ListViewModelType>(_ listViewModel: T) {
        delegate = listViewModel
        dataSource = listViewModel
        refreshControl = listViewModel.refreshControl
        listViewModel.tableView = self
    }
}
