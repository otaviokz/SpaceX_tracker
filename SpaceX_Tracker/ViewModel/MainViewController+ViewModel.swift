//
//  MainViewControllerViewModel.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit
import Combine

extension MainViewController {
    class ViewModel: NSObject, ListViewModelType {
        private(set) var launches: [Launch] = []
        private let apiClient: SpaceXAPIClient
        private var cancellables: [AnyCancellable] = []
        var onNewData: (() -> Void)?
        var openLinks: ((Links) -> Void)?
        private(set) var sections: [Section] = []
        
        private(set) var company: Company? {
            didSet { filterAndSort() }
        }
        
        private var launchesQuery = QueryResult<[Launch]>([]) {
            didSet { allLaunches = launchesQuery.results.sorted(by: >) }
        }
        
        private var allLaunches: [Launch] = [] {
            didSet { filterAndSort() }
        }
        
        var filterOptions = FilterOptions() {
            didSet { filterAndSort() }
        }
        
        private var sortAscending = false {
            didSet { filterAndSort() }
        }
        
        init(apiClient: SpaceXAPIClient) {
            self.apiClient = apiClient
        }
        
        private func filterAndSort() {
            filterOptions.update(for: allLaunches)
            launches = filterOptions.filter(allLaunches, sortAscending: sortAscending)
            calculateSections()
            onNewData?()
        }
        
        private func calculateSections() {
            sections = []
            if let company = company {
                sections.append(Section(.main_company, items: [company]))
            }
            
            if !allLaunches.isEmpty {
                sections.append(Section(.main_launches, items: launches))
            }
        }
        
        func fetchData() {
            cancellables = []
            
            apiClient.company().zip(apiClient.launches())
                .receive(on: DispatchQueue.main)
                .sink {
                    if case .failure(let error) = $0 { print(error) }
                } receiveValue: { [weak self] companyValue, launchesQuery in
                    self?.launchesQuery = launchesQuery
                    self?.company = companyValue
                }
                .store(in: &cancellables)
        }
        
        func toggleSort() {
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
            .tableSectionHeader(sections[section].title, textInset: 4)
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let launch = sections[indexPath.section].items[indexPath.row] as? Launch, launch.links.hasInfo {
            openLinks?(launch.links)
        }
    }
}
