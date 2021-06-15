//
//  YearFilterCell.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 10/06/2021.
//

import UIKit

class FilterCell: UITableViewCell, ListItemCellType {
    private static let verticalPadding: CGFloat = 4
    private static let horizontalPadding: CGFloat = 12
    private static let imageSide: CGFloat = 24
    private static let minHeight: CGFloat = 32
    
    override var accessibilityIdentifier: String? {
        set {
            super.accessibilityIdentifier = newValue
        }
        get {
            guard let identifier = super.accessibilityIdentifier else { return nil }
            return identifier + (checkmarkView.isHidden ? "" : "_selected")
        }
    }
    
    lazy var containerView = UIView().add([yearLabel, checkmarkView].constrainable)
    var checkmarkView = UIImageView(image: Images.checkmark).tint(.checkbox)
    var yearLabel = UILabel.body()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUI()
    }
    
    @discardableResult
    func configure(for item: FilterItem) -> Self {
        yearLabel.text = "\(item.title)"
        checkmarkView.isHidden = !item.checked
        return self
    }
    
    private func setUI() {
        textLabel?.numberOfLines = 0
        textLabel?.textAlignment = .left
        contentView.add(containerView.constrainable)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: 2 * Self.verticalPadding),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: Self.minHeight),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.horizontalPadding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.horizontalPadding),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.verticalPadding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.verticalPadding),
            checkmarkView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            checkmarkView.widthAnchor.constraint(equalToConstant: Self.imageSide),
            checkmarkView.heightAnchor.constraint(equalToConstant: Self.imageSide),
            checkmarkView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            yearLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            yearLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: 2 * -Self.imageSide),
            yearLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            yearLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("Not implemented!") }
}

struct FilterItem: ListItemType {
    let title: String
    let checked: Bool
}
