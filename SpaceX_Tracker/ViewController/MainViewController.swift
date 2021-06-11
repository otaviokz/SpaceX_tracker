//
//  ViewController.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import UIKit

class MainViewController: UITableViewController {
    private let viewModel: ViewModel
    var showFilter: (() -> Void)!
    
    private lazy var filterBarButton: UIBarButtonItem = {
        let menuBarItem = UIBarButtonItem(customView: filterButton)
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        return menuBarItem
    }()
    
    private lazy var sortBarButton: UIBarButtonItem = {
        let menuBarItem = UIBarButtonItem(customView: sortButton)
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 28).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 28).isActive = true
        return menuBarItem
    }()
    
    private lazy var sortButton: UIButton = {
        UIButton(type: .custom)
            .image(Style.Image.sort)
            .tint(.barbutton)
            .onTap(viewModel, action: #selector(ViewModel.toggleSort))
            .identifier("SortButton")
    }()
    
    private lazy var filterButton: UIButton = {
        UIButton(type: .custom)
            .image(Style.Image.filter)
            .tint(.barbutton)
            .onTap(self, action: #selector(showFilterView))
            .identifier("FilterButton")
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
    private func setUI() {
        title = viewModel.company?.name
        tableView.register(CompanyCell.self, forCellReuseIdentifier: CompanyCell.reuseIdentifier)
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.reuseIdentifier)
        tableView.seViewModel(viewModel)
        
        viewModel.onNewData = { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.title = self.viewModel.company?.name
            }
        }
        
        viewModel.openURL = { [unowned self] links in
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.add(urlActions: [(.main_wiki, links.wikipedia), (.main_webcast, links.webcast), (.main_article, links.article)])
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) {_ in self.dismiss(animated: true) })
            self.present(alert, animated: true)
        }
        
        navigationItem.setRightBarButtonItems([filterBarButton, sortBarButton], animated: false)
    }
    
    @objc func showFilterView() {
        showFilter()
    }
}

extension MainViewController: LaunchesFilterDelegate {
    func didFinish(with options: FilterOptions) {
        dismiss(animated: true)
        viewModel.filterOptions = options
    }
    
    func didCancel() {
        dismiss(animated: true)
    }
}

private extension UIAlertController {
    func add(urlActions: [(key: LocalizationKey, url: URL?)]) {
        urlActions.forEach {
            if let url = $0.url {
                addAction(.init(title: localize($0.key), style: .default) {_ in UIApplication.shared.open(url) })
            }
        }
    }
}
