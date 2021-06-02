//
//  MainViewControllerViewModel.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

extension MainViewController {
    class ViewModel: NSObject, ListViewModelType {
        private(set) var company: Company?
        private(set) var launches: [Launch]?
        var onNewData: (() -> Void)?
        let imageLoader: ImageLoaderType
        let apiClient: SpaceXAPIClientType
        
        init(imageLoader: ImageLoaderType, apiClient: SpaceXAPIClientType) {
            self.imageLoader = imageLoader
            self.apiClient = apiClient
        }
        
        var sections: [ListSection] {
            var sectionsArray: [ListSection] = []
            if let company = company {
                let section: ListSection = ListSection(title: localize(.main_companySectionTitle), items: [company])
                sectionsArray.append(section)
            }
            
            if let launches = launches {
                sectionsArray.append(ListSection(title: localize(.main_launchesSectionTitle), items: launches))
            }
            return sectionsArray
        }
        
        func fetchData() {
            apiClient.company { [unowned self] response in
                DispatchQueue.main.async {
                    if let company = response.apiData {
                        self.company = company
                        self.onNewData?()
                    }
                }
            }
            
            apiClient.launches { [unowned self] response in
                DispatchQueue.main.async {
                    if let launches: [Launch] = response.apiData?.documents, launches.count > 0 {
                        self.launches = launches
                        self.onNewData?()
                    }
                }
            }
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
                .add(UILabel(sections[section].title).textColor(.white).background(.clear), padding: 4)
        }
}
