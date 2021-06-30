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
        navigationController = .init(rootViewController: MainViewController(viewModel: viewModel))
    }
    
    func start() {
        viewModel.fetchData(true)
    }
}
