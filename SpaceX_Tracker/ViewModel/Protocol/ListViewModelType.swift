//
//  ListViewModel.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

protocol ListViewModelType: UITableViewDataSource, UITableViewDelegate {
    var sections: [Section] { get }
    var refreshControl: UIRefreshControl? { get }
    var tableView: UITableView? { get set }
}

extension ListViewModelType {
    var refreshControl: UIRefreshControl? { nil }
}
