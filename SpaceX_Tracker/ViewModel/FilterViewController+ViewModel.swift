//
//  LaunchFilterViewController+ViewModel.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 10/06/2021.
//

import UIKit

extension FilterViewController {
    class ViewModel: NSObject, ListViewModelType {
        var filterOptions: MainViewController.FilterOptions
        
        var sections: [ListSection] {
            let statuses = [FilterItem(title: localize(.filter_success), checked: filterOptions.success)]
            let years = filterOptions.years.map { FilterItem(title: "\($0)", checked: filterOptions.checkedYears.contains($0)) }
            
            return [ListSection(key: .filter_status, items: statuses), ListSection(key: .filter_years, items: years)]
        }
        
        init(filterOptions: MainViewController.FilterOptions) {
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
        let item = sections[indexPath.section].items[indexPath.row]
        
        if let year = item as? FilterItem, let cell: FilterCell = tableView.cell(for: indexPath) {
            return cell
                .configure(for: year)
                .accessibilityIdentifier("FilterCell_\(indexPath.section)_\(indexPath.row)")
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
        UIView()
            .background(.black)
            .add(UILabel(sections[section].title).text(.white).background(.clear), horizontalPadding: 12, verticalPadding: 4)
    }
}
