//
//  Localize.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import Foundation

func localize(_ key: LocalizationKey) -> String {
    NSLocalizedString(key.rawValue, comment: "")
}

func localize(key: FormatedLocalizationKey, with arguments: [String]) -> String {
    var baseString = NSLocalizedString(key.rawValue, comment: "")
    for index in 0..<arguments.count {
        baseString = baseString.replacingOccurrences(of: "[$\(index)]", with: arguments[index])
    }
    return baseString
}

enum LocalizationKey: String {
    case main_companySectionTitle
    case main_launchesSectionTitle
    case main_label_mission
    case main_label_date
    case main_label_rocket
    case main_label_days_since
    case main_label_days_from
    case main_dateTimeFormat
    case main_wiki
    case main_webcast
    case main_article
}

enum FormatedLocalizationKey: String {
    case main_companyDescription
}
