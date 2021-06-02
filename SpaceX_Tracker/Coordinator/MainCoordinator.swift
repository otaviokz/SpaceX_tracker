//
//  MainCoordinator.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

class MainCoordinator: Coordinating {
    let navigationController: UINavigationController
    
    init(imageLoader: ImageLoaderType) {
        let mainViewController = MainViewController(
            viewModel: .init(
                company: try! JsonLoader.sampleCompany(),
                launches: try! JsonLoader.sampleLaunches(),
                imageLoader: imageLoader
            )
        )
        self.navigationController = UINavigationController(rootViewController: mainViewController)
    }
}
