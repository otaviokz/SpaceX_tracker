//
//  MainCoordinator.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

class MainCoordinator: Coordinating {
    let navigationController: UINavigationController
    private let viewModel: MainViewController.ViewModel
    
    init(imageLoader: ImageLoaderType, apiClient: SpaceXAPIClientType) {
        viewModel = .init(imageLoader: imageLoader, apiClient: apiClient)
        let mainViewController = MainViewController(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: mainViewController)
        mainViewController.showFilter = { [unowned self] in
            let viewController = FilterViewController(viewModel: .init(filterOptions: viewModel.filterOptions), delegate: mainViewController)
            let filterNavigationController = UINavigationController(rootViewController: viewController)
            filterNavigationController.modalPresentationStyle = .overCurrentContext
            filterNavigationController.modalTransitionStyle = .coverVertical
            mainViewController.present(filterNavigationController, animated: true, completion: nil)
        } 
    }
    
    func start() {
        viewModel.fetchData()
    }
}
