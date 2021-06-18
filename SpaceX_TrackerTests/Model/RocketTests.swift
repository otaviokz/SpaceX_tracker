//
//  RocketTests.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import XCTest
@testable import SpaceX_Tracker

class RocketTests: XCTestCase {
    func testDecodeJson() throws {
        let rockets = try JsonLoader.rockets()
        
        XCTAssertEqual(rockets.map { $0.name }, ["Falcon 1", "Falcon 1", "Falcon 9"])
        XCTAssertEqual(rockets.map { $0.type }, ["rocket", "rocket", "rocket"])
    }
}
