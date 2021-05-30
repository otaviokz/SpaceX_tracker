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
    }
}

extension MainViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        
        if let company = item as? Company, let cell: CompanyCell = tableView.cell(with: item, for: indexPath) {
            return cell
                .configure(for: company)
                .accessibilityIdentifier("CompanyCell_\(indexPath.section)_\(indexPath.row)")
        }
        
        if let launch = item as? Launch, let cell: LaunchCell = tableView.cell(with: item, for: indexPath) {
            return cell
                .configure(for: launch).accessibilityIdentifier("")
                .accessibilityIdentifier("LaunchCell_\(indexPath.section)_\(indexPath.row)")
        }
        
        fatalError("Unrecognized item from ViewModel \(String(describing: item.self))")
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UILabel.darkLabel(text: viewModel.sections[section].title)
    }
}

private extension UILabel {
    static func darkLabel(text: String) -> UILabel {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.text = text
        return label
    }
}
