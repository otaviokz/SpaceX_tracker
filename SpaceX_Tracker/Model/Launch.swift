//
//  Launch.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import Foundation

struct Launch: Codable {
    static var utcFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
    
    
    let missionName: String
    let success: Bool?
    let dateUTC: String
    let dateIsTBD: Bool
    let rocket: Rocket
    let links: Links
    let localDate: Date
    
    enum CodingKeys: String, CodingKey {
        case missionName = "name"
        case success
        case dateUTC = "date_utc"
        case dateIsTBD = "tbd"
        case rocket
        case links
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Launch.CodingKeys.self)
        missionName = try container.decode(String.self, forKey: .missionName)
        success = try? container.decodeIfPresent(Bool.self, forKey: .success)
        dateUTC = try container.decode(String.self, forKey: .dateUTC)
        guard let date = Self.utcFormatter.date(from: dateUTC) else { throw DecodingError.invalidDate }
        localDate = date
        dateIsTBD = try container.decode(Bool.self, forKey: .dateIsTBD)
        rocket = try container.decode(Rocket.self, forKey: .rocket)
        links = try container.decode(Links.self, forKey: .links)
    }
}

enum DecodingError: Error {
    case invalidDate
}