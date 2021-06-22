//
//  LaunchesFilterModalViewController.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 10/06/2021.
//

import UIKit

protocol FilterDelegate: AnyObject {
    func didFinish(with options: FilterOptions)
}

class FilterViewController: UITableViewController {
    private let viewModel: ViewModel
    private weak var delegate: FilterDelegate?
    
    init(_ viewModel: ViewModel, delegate: FilterDelegate?) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(style: .grouped)        
        setUI()
    }
    
    @objc func finish() {
        delegate?.didFinish(with: viewModel.filterOptions)
    }
    
    @objc func reset() {
        delegate?.didFinish(with: .init(years: viewModel.filterOptions.years))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension FilterViewController {
    private func setUI() {
        title = localize(.filter_title)
        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.reuseIdentifier)
        tableView.setViewModel(viewModel)
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .done, target: self, action: #selector(finish)).identifier("Done")
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .trash, target: self, action: #selector(reset)).identifier("Reset")
    }
}
