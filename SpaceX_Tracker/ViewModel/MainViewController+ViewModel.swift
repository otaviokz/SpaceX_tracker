//
//  MainViewControllerViewModel.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

extension MainViewController {
    class ViewModel: NSObject, ListViewModelType {
        let company: Company?
        let launches: [Launch]?
        
        init(company: Company?, launches: [Launch]?) {
            self.company = company
            self.launches = launches
        }
        
        var sections: [ListSection] {
            var sectionsArray: [ListSection] = []
            if let company = company {
                let section: ListSection = ListSection(title: localize(.main_companySectionTitle), items: [company as ListItem])
                sectionsArray.append(section)
            }
            
            if let launches = launches {
                sectionsArray.append(ListSection(title: localize(.main_launchesSectionTitle), items: launches))
            }
            return sectionsArray
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
            
            if let company = item as? Company, let cell: CompanyCell = tableView.cell(with: item, for: indexPath) {
                return cell
                    .configure(for: company)
                    .accessibilityIdentifier("CompanyCell_\(indexPath.section)_\(indexPath.row)")
            }
            
            if let launch = item as? Launch, let cell: LaunchCell = tableView.cell(with: item, for: indexPath) {
                return cell
                    .configure(for: launch).accessibilityIdentifier("")
                    .accessibilityIdentifier("LaunchCell_\(indexPath.section)_\(indexPath.row)")
            }
            
            fatalError("Unrecognized item from ViewModel \(String(describing: item.self))")
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            UILabel.darkLabel(text: sections[section].title)
        }
}

private extension UILabel {
    static func darkLabel(text: String) -> UILabel {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.text = text
        return label
    }
}
