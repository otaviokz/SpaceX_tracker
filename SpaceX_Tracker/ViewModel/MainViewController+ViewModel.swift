//
//  MainViewControllerViewModel.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

extension MainViewController {
    enum SortOrder {
        case ascending
        case descending
    }
    
    class ViewModel: NSObject, ListViewModelType {
        private(set) var launches: [Launch] = []
        var onNewData: (() -> Void)?
        var openLinks: ((Links) -> Void)?
        private let apiClient: SpaceXAPIClientType
        
        private(set) var company: Company? {
            didSet {
                calculateSections()
                onNewData?()
            }
        }
        
        private var allLaunches: [Launch] = [] {
            didSet {
                filterOptions.years = availableYears
                filterAndSort()
            }
        }
        
        var filterOptions = FilterOptions() {
            didSet {
                filterAndSort()
            }
        }
        
        private var sortAscending = false {
            didSet {
                filterAndSort()
            }
        }
        
        func filterAndSort() {
            launches = allLaunches
            
            if filterOptions.success {
                launches = launches.filter { $0.success == true }
            }
            
            
            if filterOptions.shouldFilterYears {
                launches = launches.filter { filterOptions.isChecked(year: $0.launchYear) }
            }
            
            if sortAscending {
                launches.sort()
            }
            
            calculateSections()
            onNewData?()
        }
        
        var availableYears: [Int] {
            Set(allLaunches.map { $0.launchYear }).sorted()
        }
        
        init(apiClient: SpaceXAPIClientType) {
            self.apiClient = apiClient
        }
        
        var sections: [Section] = []
        
        func calculateSections() {
            sections = []
            if let company = company {
                sections.append(Section(.main_company, items: [company]))
            }
            
            if !allLaunches.isEmpty {
                sections.append(Section(.main_launches, items: launches))
            }
        }
        
        func fetchData() {
            apiClient.company { [unowned self] in
                self.company = $0.apiData
            }
            
            apiClient.launches { [unowned self] in
                self.allLaunches = $0.apiData?.documents.sorted(by: >) ?? []
            }
        }
        
        @objc func toggleSort() {
            sortAscending.toggle()
        }
    }
}

extension MainViewController.ViewModel: UITableViewDataSource, UITableViewDelegate {
        func numberOfSections(in tableView: UITableView) -> Int {
            sections.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            sections[section].items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let item = sections[indexPath.section].items[indexPath.row]
            
            if let item = item as? Company, let cell: CompanyCell = tableView.cell(for: indexPath) {
                return cell.configure(for: item)
            }
            
            if let launch = item as? Launch, let cell: LaunchCell = tableView.cell(for: indexPath) {
                return cell.configure(for: launch)
            }
            
            fatalError("Unrecognized item from ViewModel \(String(describing: item.self))")
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            .tableSectionHeader(sections[section].title, labelPadding: 4)
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let launch = sections[indexPath.section].items[indexPath.row] as? Launch, launch.links.hasInfo {
            openLinks?(launch.links)
        }
    }
}
