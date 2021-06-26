//
//  Launch.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import Foundation

struct Launch: Codable {
    let missionName: String
    let success: Bool?
    let dateUTC: String
    let dateIsTBD: Bool
    let rocket: Rocket
    let links: Links
    let localDate: Date
    
    enum CodingKeys: String, CodingKey {
        case success, rocket, links
        case missionName = "name"
        case dateUTC = "date_utc"
        case dateIsTBD = "tbd"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Launch.CodingKeys.self)
        missionName = try container.decode(String.self, forKey: .missionName)
        success = try container.decodeIfPresent(Bool.self, forKey: .success)
        dateUTC = try container.decode(String.self, forKey: .dateUTC)
        localDate = Style.Date.utc.date(from: dateUTC)!
        dateIsTBD = try container.decode(Bool.self, forKey: .dateIsTBD)
        rocket = try container.decode(Rocket.self, forKey: .rocket)
        links = try container.decode(Links.self, forKey: .links)
    }
    
    var launchYear: Int {
        Calendar.current.component(.year, from: localDate)
    }
}

extension Launch: Comparable {
    static func < (lhs: Launch, rhs: Launch) -> Bool {
        lhs.localDate < rhs.localDate
    }
}
