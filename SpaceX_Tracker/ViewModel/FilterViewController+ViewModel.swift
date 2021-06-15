//
//  LaunchFilterViewController+ViewModel.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 10/06/2021.
//

import UIKit

extension FilterViewController {
    class ViewModel: NSObject, ListViewModelType {
        let filterOptions: FilterOptions
        
        var sections: [ListSection] {
            let status = FilterItem(title: localize(.filter_success), checked: filterOptions.success)
            let years = filterOptions.years.map { FilterItem(title: "\($0)", checked: filterOptions.isChecked(year: $0)) }
            return [.init(key: .filter_status, items: [status]), .init(key: .filter_years, items: years)]
        }
        
        init(filterOptions: FilterOptions) {
            self.filterOptions = filterOptions
        }
    }
}

extension FilterViewController.ViewModel: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row] as? FilterItem
        
        if let year = item, let cell: FilterCell = tableView.cell(for: indexPath) {
            return cell.configure(for: year)
        }
        
        fatalError("Unrecognized item from ViewModel")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            filterOptions.toggleSucces()
        default:
            filterOptions.toggleChecked(year: filterOptions.years[indexPath.row])
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        .tableSectionHeader(sections[section].title, labelPadding: 8)
    }
}
