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
    
    private static var dateTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = localize(.main_dateTimeFormat)
        return formatter
    }
    
    let badgeimageView = UIImageView(image: UIImage(named: "badge_placeholder")).constrainable
    let missionLabel = UILabel(key: .main_label_mission).asTitle()
    let missionValueLabel = UILabel().asValue()
    let dateLabel = UILabel(key: .main_label_date).asTitle()
    let dateValueLabel = UILabel().asValue()
    let rocketLabel = UILabel(key: .main_label_rocket).asTitle()
    let rocketValueLabel = UILabel().asValue()
    let daysLabel = UILabel().asTitle()
    let daysValueLabel = UILabel().asValue()
    let successImageView = UIImageView().constrainable
    var imageURL: URL?
    
    lazy var labelsStack: UIStackView = {
        let labelsStack = UIStackView(arrangedSubviews: [missionLabel, dateLabel, rocketLabel, daysLabel]).constrainable
        labelsStack.axis = .vertical
        labelsStack.alignment = .leading
        labelsStack.spacing = 4
        return labelsStack
    }()
    
    lazy var valuesStack: UIStackView = {
        let valuesStack = UIStackView(arrangedSubviews: [missionValueLabel, dateValueLabel, rocketValueLabel, daysValueLabel]).constrainable
        valuesStack.axis = .vertical
        valuesStack.alignment = .leading
        valuesStack.spacing = 4
        return valuesStack
    }()
    
    lazy var contentStack: UIStackView = {
        let contentStack = UIStackView(arrangedSubviews: [badgeimageView, labelsStack, valuesStack, successImageView]).constrainable
        contentStack.axis = .horizontal
        contentStack.alignment = .top
        contentStack.spacing = Self.horizontalPadding
        return contentStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        badgeimageView.image = UIImage(named: "badge_placeholder")
        missionValueLabel.text = nil
        dateValueLabel.text = nil
        rocketValueLabel.text = nil
        daysLabel.text = nil
        daysValueLabel.text = nil
        successImageView.image = nil
    }
    
    @discardableResult
    func configure(for item: Launch) -> Self {
        configure(for: item, imageLoader: ImageLoader.shared)
    }
    
    @discardableResult
    func configure(for item: Launch, imageLoader: ImageLoaderType) -> Self {
        missionValueLabel.text = item.missionName
        dateValueLabel.text = Self.dateTimeFormatter.string(from: item.localDate)
        rocketValueLabel.text = "\(item.rocket.name) / \(item.rocket.type)"
        let now = Date()
        if item.localDate <= now {
            daysLabel.text = localize(.main_label_days_since)
            if let days = days(from: item.localDate, to: now) {
                daysValueLabel.text = "\(days)"
            }
        } else {
            daysLabel.text = localize(.main_label_days_from)
            if let days = days(from: now, to: item.localDate) {
                daysValueLabel.text = "\(days)"
            }
        }
        
        if let success = item.success {
            let imageName = success ? "success" : "failure"
            successImageView.image = UIImage(named: imageName)
        }
        
        imageURL = item.links.patch.small
        if let itemUrl = imageURL {
            imageLoader.image(for: itemUrl) { [unowned self] in
                guard let url = self.imageURL, url == $0.data?.1, let image = $0.data?.0 else { return }
                DispatchQueue.main.async {
                    self.badgeimageView.image = image
                    self.badgeimageView.accessibilityIdentifier = url.absoluteString
                }
            }
        }
        
        return self
    }
    
    private func setUI() {
        badgeimageView.tintColor = .black
        successImageView.tintColor = .black
        
        contentView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: contentStack.heightAnchor, constant: 3 * Self.verticalPadding),
            contentStack.heightAnchor.constraint(equalTo: labelsStack.heightAnchor),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.horizontalPadding),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.horizontalPadding),
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2 * Self.verticalPadding),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.verticalPadding),
            labelsStack.widthAnchor.constraint(equalTo: valuesStack.widthAnchor),
            
            badgeimageView.widthAnchor.constraint(equalToConstant: Self.imageSide),
            badgeimageView.heightAnchor.constraint(equalToConstant: Self.imageSide),
            successImageView.heightAnchor.constraint(equalToConstant: Self.imageSide),
            successImageView.widthAnchor.constraint(equalToConstant: Self.imageSide),
            missionLabel.heightAnchor.constraint(equalTo: missionValueLabel.heightAnchor),
            dateLabel.heightAnchor.constraint(equalTo: dateValueLabel.heightAnchor),
            rocketLabel.heightAnchor.constraint(equalTo: rocketValueLabel.heightAnchor),
            daysLabel.heightAnchor.constraint(equalTo: daysValueLabel.heightAnchor),
            badgeimageView.topAnchor.constraint(equalTo: missionLabel.topAnchor),
            successImageView.topAnchor.constraint(equalTo: missionValueLabel.topAnchor)
        ])
    }
    
    private func days(from startDate: Date, to endDate: Date) -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("Not implemented!") }
}

extension Launch: ListItemType {}

private extension UILabel {
    @discardableResult
    func asTitle() -> Self {
        textColor = .gray
        return self.resizable()
    }
    
    @discardableResult
    func asValue() -> Self {
        textColor = .black
        return self.resizable()
    }
    
    @discardableResult
    func resizable() -> Self {
        numberOfLines = 0
        return self.constrainable
    }
}
