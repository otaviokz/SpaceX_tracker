//
//  ListViewModel.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

protocol ListViewModelType: UITableViewDataSource, UITableViewDelegate {
    var sections: [ListSection] { get }
}
