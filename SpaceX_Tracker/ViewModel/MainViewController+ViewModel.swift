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
    
    struct FilterOptions {
        var years: [Int] = [] {
            didSet {
                checkedYears = Set(checkedYears).union(Set(years)).sorted()
            }
        }
        
        var checkedYears: [Int] = []
        var success: Bool = false
        
        init(availableYears: [Int] = []) {
            self.years = availableYears
        }
        
        mutating func toggleChecked(year: Int) {
            checkedYears = Set(checkedYears + [year]).sorted()
        }
        
        mutating func toggleSucces() {
            success.toggle()
        }
    }
    
    class ViewModel: NSObject, ListViewModelType {
        private(set) var filteredLaunches: [Launch] = []
        var onNewData: (() -> Void)?
        var openURL: ((Links) -> Void)?
        private let imageLoader: ImageLoaderType
        private let apiClient: SpaceXAPIClientType
        
        private(set) var company: Company? {
            didSet {
                onNewData?()
            }
        }
        
        var launches: [Launch] = [] {
            didSet {
                filterOptions.years = availableYears
                filterAndSort()
                onNewData?()
            }
        }
        
        var filterOptions = FilterOptions() {
            didSet {
                filterAndSort()
                onNewData?()
            }
        }
        
        private var sortDescending = true {
            didSet {
                filterAndSort()
                onNewData?()
            }
        }
        
        func filterAndSort() {
            filteredLaunches = launches
            
            if !filterOptions.checkedYears.isEmpty {
                filteredLaunches = filteredLaunches.filter {
                    filterOptions.checkedYears.contains($0.launchYear)
                }
            }
            
            if filterOptions.success {
                filteredLaunches = filteredLaunches.filter { $0.success == true }
            }
            
            filteredLaunches.sort()
            if sortDescending {
                filteredLaunches.reverse()
            }
        }
        
        var availableYears: [Int] {
            Set(launches.map { $0.launchYear }).sorted()
        }
        
        init(imageLoader: ImageLoaderType, apiClient: SpaceXAPIClientType) {
            self.imageLoader = imageLoader
            self.apiClient = apiClient
        }
        
        var sections: [ListSection] {
            var sectionsArray: [ListSection] = []
            if let company = company {
                let section: ListSection = ListSection(key: .main_companySectionTitle, items: [company])
                sectionsArray.append(section)
            }
            
            return sectionsArray + [ListSection(key: .main_launchesSectionTitle, items: filteredLaunches)]
        }
        
        func fetchData() {
            apiClient.company { [unowned self] in
                self.company = $0.apiData
            }
            
            apiClient.launches { [unowned self] in
                self.launches = $0.apiData?.documents ?? []
            }
        }
        
        @objc func toggleSort() {
            sortDescending.toggle()
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
            
            if let company = item as? Company, let cell: CompanyCell = tableView.cell(for: indexPath) {
                return cell
                    .configure(for: company)
                    .accessibilityIdentifier("CompanyCell_\(indexPath.section)_\(indexPath.row)")
            }
            
            if let launch = item as? Launch, let cell: LaunchCell = tableView.cell(for: indexPath) {
                return cell
                    .configure(for: launch, imageLoader: imageLoader)
                    .accessibilityIdentifier("LaunchCell_\(indexPath.section)_\(indexPath.row)")
            }
            
            fatalError("Unrecognized item from ViewModel \(String(describing: item.self))")
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            UIView()
               
                .background(.black)
                .add(UILabel(sections[section].title).text(.white).background(.clear), padding: 4)
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let launch = sections[indexPath.section].items[indexPath.row] as? Launch, launch.links.hasInfo {
            openURL?(launch.links)
        }
    }
}
