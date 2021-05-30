//
//  MainViewControllerViewModel.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import Foundation

extension MainViewController {
    struct ViewModel: ListViewModel {
        let company: Company?
        let launches: [Launch]?
        
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
