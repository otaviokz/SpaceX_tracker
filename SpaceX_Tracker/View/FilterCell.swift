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
            (super.accessibilityIdentifier ?? "") + (checkmarkView.isHidden ? "" : "_selected")
        }
    }
    
    lazy var containerView = UIView().add([titleLabel, checkmarkView].constrainable)
    var checkmarkView = UIImageView(image: Images.checkmark).tint(.checkbox)
    var titleLabel = UILabel.body()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    @discardableResult
    func configure(for item: FilterItem) -> Self {
        titleLabel.text = "\(item.title)"
        checkmarkView.isHidden = !item.checked
        return self
    }
    
    private func setUI() {
        backgroundColor = traitCollection.userInterfaceStyle == .light ? .white : .darkGray
        selectionStyle = .none
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
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: 2 * -Self.imageSide),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("Not implemented!") }
}

struct FilterItem: ItemType {
    let title: String
    let checked: Bool
}
