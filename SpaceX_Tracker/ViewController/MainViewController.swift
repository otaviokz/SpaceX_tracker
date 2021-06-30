//
//  ViewController.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import UIKit
import Combine

class MainViewController: UITableViewController {
    private let buttonSize: CGFloat = 28
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
        tableView.register(CompanyCell.self, forCellReuseIdentifier: CompanyCell.reuseIdentifier)
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.reuseIdentifier)
        tableView.setViewModel(viewModel)
        
        filterBarButton.customView?.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        filterBarButton.customView?.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        sortBarButton.customView?.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        sortBarButton.customView?.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        navigationItem.setRightBarButtonItems([filterBarButton, sortBarButton], animated: false)
        
        viewModel.$canFilter.assign(to: \.isEnabled, on: filterBarButton).store(in: &subscriptions)
        viewModel.$canFilter.assign(to: \.isEnabled, on: sortBarButton).store(in: &subscriptions)
        viewModel.$navigationTitle.assign(to: \.title, on: navigationItem).store(in: &subscriptions)
        
        viewModel.$links.sink { [unowned self] links in
            guard let links = links else { return }
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.add(links)
            alert.addAction(.init(title: localize(.main_cancel), style: .cancel) {_ in dismiss(animated: true) })
            present(alert, animated: true)
        }.store(in: &subscriptions)
    }
    
    @objc func toggleSort() {
        viewModel.toggleSort()
    }
    
    @objc func showFilter() {
        let controller = UINavigationController(rootViewController: FilterViewController(.init(viewModel.filterOptions), delegate: self))
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .coverVertical
        present(controller, animated: true)
    }
}

extension MainViewController: FilterDelegate {
    func didFinish(with options: FilterOptions) {
        dismiss(animated: true)
        viewModel.filterOptions = options
    }
}

private extension UIAlertController {
    func add(_ urlActions: [(LocalizationKey, URL)]) {
        urlActions.forEach { key, url in
            addAction(.init(title: localize(key), style: .default) {_ in UIApplication.shared.open(url) })
        }
    }
}
