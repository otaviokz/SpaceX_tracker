//
//  Links.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import Foundation

struct Links: Codable, Equatable {
    let patch: Patch
    let webcast: URL?
    let article: URL?
    let wikipedia: URL?
    
    var hasInfo: Bool {
        ![webcast, article, wikipedia].compactMap {$0}.isEmpty
    }
}
