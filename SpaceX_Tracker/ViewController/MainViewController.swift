//
//  ViewController.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import UIKit
import Combine

class MainViewController: UITableViewController {
    var showFilterAction: (() -> Void)?
    private let viewModel: ViewModel
    private var subscriptions: [AnyCancellable] = []
    
    private lazy var filterBarButton = UIBarButtonItem(
        customView: UIButton().image(Images.filter).onTap(self, #selector(showFilter))
    ).identifier("FilterButton")
        
    private lazy var sortBarButton = UIBarButtonItem(
        customView: UIButton().image(Images.sort).onTap(self, #selector(toggleSort))
    ).identifier("SortButton")
     
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(style: .grouped)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension MainViewController {
    func setUI() {
        viewModel.$canFilter.assign(to: \.isEnabled, on: filterBarButton).store(in: &subscriptions)
        viewModel.$navigationTitle.assign(to: \.title, on: navigationItem).store(in: &subscriptions)
        
        tableView.register(CompanyCell.self, forCellReuseIdentifier: CompanyCell.reuseIdentifier)
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.reuseIdentifier)
        tableView.setViewModel(viewModel)
 
        viewModel.$links.sink { [weak self] links in
            guard let links = links, let self = self else { return }
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.add(links)
            alert.addAction(.init(title: localize(.main_cancel), style: .cancel) {_ in self.dismiss(animated: true) })
            self.present(alert, animated: true)
        }.store(in: &subscriptions)
        
        filterBarButton.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        filterBarButton.customView?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        sortBarButton.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        sortBarButton.customView?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        navigationItem.setRightBarButtonItems([filterBarButton, sortBarButton], animated: false)
    }
    
    @objc func toggleSort() {
        viewModel.toggleSort()
    }
    
    @objc func showFilter() {
        showFilterAction?()
    }
}

extension MainViewController: FilterDelegate {
    func didFinish(with options: FilterOptions) {
        dismiss(animated: true)
        viewModel.filterOptions = options
    }
}

private extension UIAlertController {
    func add(_ urlActions: [(LocalizationKey, URL?)]) {
        urlActions.forEach { key, url in
            if let url = url {
                addAction(.init(title: localize(key), style: .default) {_ in UIApplication.shared.open(url) })
            }
        }
    }
}
