//
//  LaunchesFilterModalViewController.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 10/06/2021.
//

import UIKit

protocol LaunchesFilterDelegate: AnyObject {
    func didFinish(with options: MainViewController.FilterOptions)
    func didCancel()
}

class FilterViewController: UITableViewController {
    private let viewModel: ViewModel
    private weak var delegate: LaunchesFilterDelegate?
    
    init(viewModel: ViewModel, delegate: LaunchesFilterDelegate?) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(style: .grouped)
        
        setUI()
    }
    
    @objc func finish() {
        delegate?.didFinish(with: viewModel.filterOptions)
    }
    
    @objc func reset() {
        delegate?.didFinish(with: .init(availableYears: viewModel.filterOptions.years))
    }
    
    @objc func cancel() {
        delegate?.didCancel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension FilterViewController {
    private func setUI() {
        title = localize(.filter_title)
        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.reuseIdentifier)
        tableView.seViewModel(viewModel)
        navigationItem.setRightBarButtonItems(
            [
                UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(finish)).identifier("Save"),
                UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(reset)).identifier("Reset")
            ], animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel)).identifier("Cancel")
    }
}
