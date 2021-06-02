//
//  CompanyCell.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

class CompanyCell: UITableViewCell, ListItemCellType {
    private static let verticalPadding: CGFloat = 4
    private static let horizontalPadding: CGFloat = 4
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        textLabel?.setConstrainable()
        setUI()
    }
    
    @discardableResult
    func configure(for item: Company) -> Self {
        textLabel?.text = item.localizedDescription
        return self
    }
    
    private func setUI() {
        textLabel?.numberOfLines = 0
        textLabel?.textAlignment = .left
        
        
        if let label = textLabel {
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.horizontalPadding),
                label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.horizontalPadding),
                label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.verticalPadding),
                label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.verticalPadding)
            ])
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("Not implemented!") }
}

extension Company: ListItemType {}

private extension Company {
    var localizedDescription: String {
        localize(
            key: .main_companyDescription,
            with: [name, founder, "\(foundationYear)", "\(employees)", "\(launchSites)", "\(valuationUSD)"]
        )
    }
}
