//
//  JSONLoader+TestData.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import Foundation
@testable import SpaceX_Tracker

extension JsonLoader {
    static func launches() throws -> [Launch] { try loadJson("TestLaunches_PopulatedRockets_v4") }
    static func rockets() throws -> [Rocket] { try loadJson("TestRockets_v4") }
    static func links() throws -> [Links] { try loadJson("TestLinks_v4") }
    static func patches() throws -> [Patch] { try loadJson("TestPatches_v4") }
    static func company() throws -> Company { try loadJson("TestCompanyInfo_v4") }
}
