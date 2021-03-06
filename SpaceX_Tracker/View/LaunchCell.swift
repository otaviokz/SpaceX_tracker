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
    private static let badgeSize: CGFloat = 32
    private static let imageSize: CGFloat = 24
    private static let labelSpacingTop: CGFloat = 4
    private let badgeImageView = UIImageView()
    private let missionLabel = UILabel.grayBody(localize(.main_mission))
    private let missionValueLabel = UILabel.body()
    private let dateLabel = UILabel.grayBody(localize(.main_date))
    private let dateValueLabel = UILabel.body()
    private let rocketLabel = UILabel.grayBody(localize(.main_rocket))
    private let rocketValueLabel = UILabel.body()
    private let daysLabel = UILabel.grayBody()
    private let daysValueLabel = UILabel.body()
    private let successImageView = UIImageView()
    private let linkImageView = UIImageView(image: Images.link)
    private var imageURL: URL?
    
    private lazy var labelsStack: UIStackView = {
        let labelsStack = UIStackView(arrangedSubviews: [missionLabel, dateLabel, rocketLabel, daysLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = Self.labelSpacingTop
        return labelsStack
    }()
    
    private lazy var valuesStack: UIStackView = {
        let valuesStack = UIStackView(arrangedSubviews: [missionValueLabel, dateValueLabel, rocketValueLabel, daysValueLabel])
        valuesStack.axis = .vertical
        valuesStack.spacing = Self.labelSpacingTop
        return valuesStack
    }()
    
    private lazy var contentStack: UIStackView = {
        let contentStack = UIStackView(arrangedSubviews: [badgeImageView, labelsStack, valuesStack, imagesStack])
        contentStack.alignment = .top
        contentStack.spacing = Self.horizontalPadding
        return contentStack
    }()
    
    private lazy var imagesStack = UIView().add([successImageView, linkImageView].constrainable)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        badgeImageView.image = nil
        daysValueLabel.text = nil
        successImageView.image = nil
        imageURL = nil
    }
    
    @discardableResult
    func configure(for item: Launch) -> Self {
        missionValueLabel.text = item.missionName
        dateValueLabel.text = Style.Date.local.string(from: item.localDate)
        rocketValueLabel.text = "\(item.rocket.name) / \(item.rocket.type)"
        
        let now = Date()
        daysLabel.text = localize(item.localDate <= now ? .main_days_since : .main_days_from)
        if let days = days(from: min(now, item.localDate), to: max(now, item.localDate)) {
            daysValueLabel.text = "\(days)"
        }
        
        if let success = item.success {
            successImageView.image = success ? Images.success : Images.failure
        }
        
        if let currentURL = item.links.patch.small {
            imageURL = currentURL
            ImageLoader.shared.image(for: currentURL) { [weak self] in
                guard let image = $0.data?.0, self?.imageURL == $0.data?.1 else { return }
                DispatchQueue.main.async { self?.badgeImageView.image = image }
            }
        }
        
        linkImageView.isHidden = !item.links.hasInfo
        return self
    }
    
    private func setUI() {
        selectionStyle = .none
        successImageView.tint(.imageTint)
        contentView.add(contentStack.constrainable)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: contentStack.heightAnchor, constant: 3 * Self.verticalPadding),
            contentStack.heightAnchor.constraint(equalTo: labelsStack.heightAnchor),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.horizontalPadding),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.horizontalPadding),
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2 * Self.verticalPadding),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.verticalPadding),
            labelsStack.widthAnchor.constraint(equalTo: valuesStack.widthAnchor),
            badgeImageView.widthAnchor.constraint(equalToConstant: Self.badgeSize),
            badgeImageView.heightAnchor.constraint(equalToConstant: Self.badgeSize),
            badgeImageView.topAnchor.constraint(equalTo: missionLabel.topAnchor),
            missionLabel.heightAnchor.constraint(equalTo: missionValueLabel.heightAnchor),
            dateLabel.heightAnchor.constraint(equalTo: dateValueLabel.heightAnchor),
            rocketLabel.heightAnchor.constraint(equalTo: rocketValueLabel.heightAnchor),
            daysLabel.heightAnchor.constraint(equalTo: daysValueLabel.heightAnchor),
            imagesStack.widthAnchor.constraint(equalToConstant: Self.imageSize),
            imagesStack.heightAnchor.constraint(equalTo: labelsStack.heightAnchor),
            successImageView.widthAnchor.constraint(equalToConstant: Self.imageSize),
            successImageView.heightAnchor.constraint(equalToConstant: Self.imageSize),
            successImageView.topAnchor.constraint(equalTo: missionValueLabel.topAnchor),
            linkImageView.heightAnchor.constraint(equalToConstant: Self.imageSize),
            linkImageView.widthAnchor.constraint(equalToConstant: Self.imageSize),
            linkImageView.bottomAnchor.constraint(equalTo: daysValueLabel.bottomAnchor)
        ])
    }
    
    private func days(from startDate: Date, to endDate: Date) -> Int? {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("Not implemented!") }
}

extension Launch: ItemType {}
