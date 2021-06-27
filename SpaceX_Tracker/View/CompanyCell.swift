//
//  CompanyCell.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

class CompanyCell: UITableViewCell, ListItemCellType {
    private static let padding: CGFloat = 4
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    @discardableResult
    func configure(for item: Company) -> Self {
        textLabel?.text = item.localizedDescription
        return self
    }
    
    private func setUI() {
        selectionStyle = .none
        textLabel?.numberOfLines = 0
        textLabel?.textAlignment = .left
        textLabel?.font(.body)
        textLabel?.constrainable.constrainTo(contentView, constant: Self.padding)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("Not implemented!") }
}

extension Company: ItemType {}

private extension Company {
    var localizedDescription: String {
        localize(.company_info, [name, founder, "\(foundationYear)", "\(employees)", "\(launchSites)", "\(valuationUSD)"])
    }
}
