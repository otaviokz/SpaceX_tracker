//
//  LaunchFilterViewController+ViewModel.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 10/06/2021.
//

import UIKit
import Combine

extension FilterViewController {
    class ViewModel: NSObject, ListViewModelType {
        @Published private(set) var showResetButton: Bool = false
        var tableView: UITableView?
        private(set) var sections: [Section] = []
        private var subscriptions = Set<AnyCancellable>()
        let filterOptions: FilterOptions
        
        init(_ filterOptions: FilterOptions) {
            self.filterOptions = filterOptions
            super.init()
            calculateSections()
            
            filterOptions.$isFiltering.assign(to: \.showResetButton, on: self).store(in: &subscriptions)
        }
    }
}

extension FilterViewController.ViewModel: UITableViewDataSource, UITableViewDelegate {
    private func calculateSections() {
        let status = FilterItem(title: localize(.filter_success), checked: filterOptions.success)
        let years = filterOptions.years.map { FilterItem(title: "\($0)", checked: filterOptions.isChecked(year: $0)) }
        sections = [Section(.filter_status, items: [status]), Section(.filter_years, items: years)]
    }
    
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
        calculateSections()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        .tableSectionHeader(sections[section].title, textInset: 8)
    }
}
