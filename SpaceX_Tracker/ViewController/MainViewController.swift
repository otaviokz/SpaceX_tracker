//
//  ViewController.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import UIKit

class MainViewController: UITableViewController {
    private let viewModel: ViewModel
    var showFilterAction: (() -> Void)?
    
    private lazy var filterBarButton: UIBarButtonItem = {
        let button = UIButton().image(Images.filter).onTap(self, #selector(showFilter)).identifier("SortButton")
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        return menuBarItem
    }()
    
    private lazy var sortBarButton: UIBarButtonItem = {
        let button = UIButton().image(Images.sort).onTap(self, #selector(toggleSort)).identifier("SortButton")
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        return menuBarItem
    }()
    
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
        title = viewModel.company?.name
        tableView.register(CompanyCell.self, forCellReuseIdentifier: CompanyCell.reuseIdentifier)
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.reuseIdentifier)
        tableView.setViewModel(viewModel)
        
        viewModel.onNewData = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.title = self.viewModel.company?.name
            }
        }
        
        viewModel.openLinks = { [unowned self] in
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.add([(.main_wiki, $0.wikipedia), (.main_webcast, $0.webcast), (.main_article, $0.article)])
            alert.addAction(.init(title: localize(.main_cancel), style: .cancel) {_ in dismiss(animated: true) })
            self.present(alert, animated: true)
        }
        
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
