//
//  Localize.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import Foundation

func localize(_ key: LocalizationKeys) -> String {
    NSLocalizedString(key.rawValue, comment: "")
}

func localize(key: FormatedLocalizationKeys, with arguments: [String]) -> String {
    var baseString = NSLocalizedString(key.rawValue, comment: "")
    for index in 0..<arguments.count {
        baseString = baseString.replacingOccurrences(of: "[$\(index)]", with: arguments[index])
    }
    return baseString
}

enum LocalizationKeys: String {
    case main_companySectionTitle
    case main_launchesSectionTitle
    case main_label_mission
    case main_label_date
    case main_label_rocket
    case main_label_days_since
    case main_label_days_from
    case main_dateTimeFormat
}

enum FormatedLocalizationKeys: String {
    case main_companyDescription
}
