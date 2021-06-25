//
//  MainCoordinator.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

class MainCoordinator: Coordinating {
    let navigationController: UINavigationController
    private var viewModel: MainViewController.ViewModel
    
    init(apiClient: SpaceXAPIClient) {
        viewModel = .init(apiClient: apiClient)
        let viewController = MainViewController(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: viewController)
        viewController.showFilterAction = { [viewModel] in
            let filterMenu = FilterViewController(.init(filterOptions: viewModel.filterOptions), delegate: viewController)
            let filterNavigationController = UINavigationController(rootViewController: filterMenu)
            filterNavigationController.modalPresentationStyle = .overCurrentContext
            filterNavigationController.modalTransitionStyle = .coverVertical
            viewController.present(filterNavigationController, animated: true, completion: nil)
        } 
    }
    
    func start() {
        viewModel.fetchData()
    }
}
