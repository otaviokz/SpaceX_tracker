//
//  LaunchCell.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import UIKit

class LaunchCell: UITableViewCell, ListItemCellType {
    private static let verticalPadding: CGFloat = 8
    private static let horizontalPadding: CGFloat = 4
    private static let imageSide: CGFloat = 32
    private static let labelSpacingTop: CGFloat = 4
    
    private static var dateTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = localize(.main_dateTimeFormat)
        return formatter
    }
    
    private let badgeImageView = UIImageView(image: Images.badgePlaceholder)
    private let missionLabel = UILabel.grayBody(localize(.main_mission))
    private let missionValueLabel = UILabel.body()
    private let dateLabel = UILabel.grayBody(localize(.main_date))
    private let dateValueLabel = UILabel.body()
    private let rocketLabel = UILabel.grayBody(localize(.main_rocket))
    private let rocketValueLabel = UILabel.body()
    private let daysLabel = UILabel.grayBody()
    private let daysValueLabel = UILabel.body()
    private let successImageView = UIImageView()
    private var imageURL: URL?
    
    private lazy var labelsStack: UIStackView = {
        let labelsStack = UIStackView(arrangedSubviews: [missionLabel, dateLabel, rocketLabel, daysLabel])
        labelsStack.axis = .vertical
        labelsStack.alignment = .fill
        labelsStack.spacing = Self.labelSpacingTop
        return labelsStack
    }()
    
    private lazy var valuesStack: UIStackView = {
        let valuesStack = UIStackView(arrangedSubviews: [missionValueLabel, dateValueLabel, rocketValueLabel, daysValueLabel])
        valuesStack.axis = .vertical
        valuesStack.alignment = .fill
        valuesStack.spacing = Self.labelSpacingTop
        return valuesStack
    }()
    
    private lazy var contentStack: UIStackView = {
        let contentStack = UIStackView(arrangedSubviews: [badgeImageView, labelsStack, valuesStack, successImageView])
        contentStack.axis = .horizontal
        contentStack.alignment = .top
        contentStack.spacing = Self.horizontalPadding
        return contentStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        badgeImageView.image = Images.badgePlaceholder
        missionValueLabel.text = nil
        dateValueLabel.text = nil
        rocketValueLabel.text = nil
        daysLabel.text = nil
        daysValueLabel.text = nil
        successImageView.image = nil
        imageURL = nil
    }
    
    @discardableResult
    func configure(for item: Launch) -> Self {
        missionValueLabel.text = item.missionName
        dateValueLabel.text = Self.dateTimeFormatter.string(from: item.localDate)
        rocketValueLabel.text = "\(item.rocket.name) / \(item.rocket.type)"
        let now = Date()
        if item.localDate <= now {
            daysLabel.text = localize(.main_days_since)
            if let days = days(from: item.localDate, to: now) {
                daysValueLabel.text = "\(days)"
            }
        } else {
            daysLabel.text = localize(.main_days_from)
            if let days = days(from: now, to: item.localDate) {
                daysValueLabel.text = "\(days)"
            }
        }
        
        if let success = item.success {
            successImageView.image = success ? Images.success : Images.failure
        }
        
        imageURL = item.links.patch.small
        if let itemUrl = imageURL {
            ImageLoader.shared.image(for: itemUrl) { [unowned self] in
                guard let url = self.imageURL, url == $0.data?.1, let image = $0.data?.0 else { return }
                DispatchQueue.main.async {
                    self.badgeImageView.image = image
                    self.badgeImageView.image?.accessibilityIdentifier = url.absoluteString
                    self.badgeImageView.accessibilityIdentifier = url.absoluteString
                }
            }
        }
        
        return self
    }
    
    private func setUI() {
        selectionStyle = .none
        badgeImageView.tint(.solidBlack)
        successImageView.tint(.solidBlack)
        
        contentView.add(contentStack.constrainable)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: contentStack.heightAnchor, constant: 3 * Self.verticalPadding),
            contentStack.heightAnchor.constraint(equalTo: labelsStack.heightAnchor),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.horizontalPadding),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.horizontalPadding),
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2 * Self.verticalPadding),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.verticalPadding),
            labelsStack.widthAnchor.constraint(equalTo: valuesStack.widthAnchor),
            badgeImageView.widthAnchor.constraint(equalToConstant: Self.imageSide),
            badgeImageView.heightAnchor.constraint(equalToConstant: Self.imageSide),
            successImageView.heightAnchor.constraint(equalToConstant: Self.imageSide),
            successImageView.widthAnchor.constraint(equalToConstant: Self.imageSide),
            missionLabel.heightAnchor.constraint(equalTo: missionValueLabel.heightAnchor),
            dateLabel.heightAnchor.constraint(equalTo: dateValueLabel.heightAnchor),
            rocketLabel.heightAnchor.constraint(equalTo: rocketValueLabel.heightAnchor),
            daysLabel.heightAnchor.constraint(equalTo: daysValueLabel.heightAnchor),
            badgeImageView.topAnchor.constraint(equalTo: missionLabel.topAnchor),
            successImageView.topAnchor.constraint(equalTo: missionValueLabel.topAnchor)
        ])
    }
    
    private func days(from startDate: Date, to endDate: Date) -> Int? {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("Not implemented!") }
}

extension Launch: ItemType {}
