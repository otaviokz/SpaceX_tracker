//
//  ViewController.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import UIKit

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        setUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension MainViewController {
    func setUI() {
        title = viewModel.company?.name
        tableView.register(CompanyCell.self, forCellReuseIdentifier: CompanyCell.reuseIdentifier)
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.reuseIdentifier)
        tableView.seViewModel(viewModel)
    }
}
