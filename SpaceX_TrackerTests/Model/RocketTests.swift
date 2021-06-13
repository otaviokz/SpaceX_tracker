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
        let sampleRockets = try? JsonLoader.rockets()
        XCTAssertNotNil(sampleRockets)
        
        for index in 0...2 {
            if let rocket = sampleRockets?[index]  {
                XCTAssertEqual(rocket.name, expectedNames[index])
                XCTAssertEqual(rocket.type, expectedTypes[index])
            } else {
                XCTFail("Array missing item for index: \(index)")
            }
        }
    }
}

private extension RocketTests {
    var expectedNames: [String] { ["Falcon 1", "Falcon 1", "Falcon 9"] }
    var expectedTypes: [String] { ["rocket", "rocket", "rocket"] }
}
