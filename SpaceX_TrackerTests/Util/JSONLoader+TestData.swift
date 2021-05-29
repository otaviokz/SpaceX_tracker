//
//  JSONLoader+TestData.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import Foundation
@testable import SpaceX_Tracker

extension JsonLoader {
    static func sampleLaunches() throws -> [Launch] { try loadJson("TestLaunches_PopulatedRockets_v4") }
    static func sampleRockets() throws -> [Rocket] { try loadJson("TestRockets_v4") }
    static func sampleLinks() throws -> [Links] { try loadJson("TestLinks_v4") }
    static func samplePatches() throws -> [Patch] { try loadJson("TestPatches_v4") }
    static func sampleCompany() throws -> Company { try loadJson("TestCompanyInfo_v4") }
}
