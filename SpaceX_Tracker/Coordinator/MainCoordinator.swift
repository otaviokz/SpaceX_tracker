//
//  MainCoordinator.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

class MainCoordinator: Coordinating {
    let navigationController: UINavigationController
    let mainViewModel: MainViewController.ViewModel
    
    init(imageLoader: ImageLoaderType, apiClient: SpaceXAPIClientType) {
        mainViewModel = .init(imageLoader: imageLoader, apiClient: apiClient)
        let mainViewController = MainViewController(viewModel: mainViewModel)
        self.navigationController = UINavigationController(rootViewController: mainViewController)
    }
    
    func start() {
        mainViewModel.fetchData()
    }
}
