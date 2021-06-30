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
        @Published private(set) var navigationTitle: String?
        @Published private(set) var canFilter: Bool = false
        @Published private(set) var links: [(LocalizationKey, URL)]?
        var tableView: UITableView?
        private let apiClient: SpaceXAPIClient
        private var subscriptions: Set<AnyCancellable> = []
        private(set) var sections: [Section] = []
        
        lazy var refreshControl: UIRefreshControl? = {
           let controll = UIRefreshControl()
            controll.addTarget(self, action: #selector(fetchData), for: .valueChanged)
            return controll
        }()
        
        private var company: Company? { didSet { computeState() } }
        private var launches: [Launch] = []
        private var launchesQuery = QueryResult<[Launch]>([]) {
            didSet { allLaunches = launchesQuery.results.sorted(by: >) }
        }
        
        private var allLaunches: [Launch] = [] {
            didSet { computeState() }
        }
        
        var filterOptions = FilterOptions() {
            didSet { computeState() }
        }
        
        private var sortAscending = false {
            didSet { computeState() }
        }
        
        init(apiClient: SpaceXAPIClient) {
            self.apiClient = apiClient
        }
        
        private func computeState() {
            canFilter = !allLaunches.isEmpty
            navigationTitle = company?.name
            filterOptions.update(for: allLaunches)
            launches = filterOptions.filter(allLaunches, sortAscending: sortAscending)
            calculateSections()
            tableView?.reloadData()
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
        
        @objc func fetchData(_ showRefresh: Bool = false) {
            if showRefresh {
                refreshControl?.beginRefreshing()
            }
            
            subscriptions = []
            
            apiClient.company().zip(apiClient.launches()).receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    if case .failure(let error) = $0 { print(error) }
                    self?.refreshControl?.endRefreshing()
                } receiveValue: { [weak self] companyValue, launchesQuery in
                    self?.launchesQuery = launchesQuery
                    self?.company = companyValue
                }.store(in: &subscriptions)
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
        
        if let company = item as? Company, let cell: CompanyCell = tableView.cell(for: indexPath) {
            return cell.configure(for: company)
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
        if let launch = sections[indexPath.section].items[indexPath.row] as? Launch {
            links = launch.links.hasInfo ? launch.links.infoLinks : nil
        }
    }
}
