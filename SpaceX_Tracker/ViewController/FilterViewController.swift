//
//  LaunchesFilterModalViewController.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 10/06/2021.
//

import UIKit
import Combine

protocol FilterDelegate: AnyObject {
    func didFinish(with options: FilterOptions)
}

class FilterViewController: UITableViewController {
    private let viewModel: ViewModel
    private weak var delegate: FilterDelegate?
    private lazy var doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done)).identifier("Done")
    private lazy var resetButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(reset)).identifier("Reset")
    private var subscriptions = Set<AnyCancellable>()
    
    init(_ viewModel: ViewModel, delegate: FilterDelegate?) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(style: .grouped)        
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension FilterViewController {
    func setUI() {
        title = localize(.filter_title)
        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.reuseIdentifier)
        tableView.setViewModel(viewModel)
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem =  resetButton
        viewModel.$showResetButton.assign(to: \.isEnabled, on: resetButton).store(in: &subscriptions)
    }
    
    @objc func done() {
        delegate?.didFinish(with: viewModel.filterOptions)
    }
    
    @objc func reset() {
        delegate?.didFinish(with: .init(years: viewModel.filterOptions.years))
    }
}
