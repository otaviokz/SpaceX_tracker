//
//  LaunchTests.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import XCTest
@testable import SpaceX_Tracker

class LaunchTests: XCTestCase {
    func testDecodeJson() throws {
        let sampleRockets = try JsonLoader.rockets() //tested in PatchTests
        let sampleLinks = try JsonLoader.links() //tested in LinksTests
        
        let sampleLaunches = try? JsonLoader.launches()
        XCTAssertNotNil(sampleLaunches)
        
        for index in 0...2 {
            if let launch = sampleLaunches?[index]  {
                XCTAssertEqual(launch.missionName, expectedMissionNames[index])
                XCTAssertEqual(launch.success, expectedSuccess[index])
                XCTAssertEqual(launch.dateUTC, expectedUTCDates[index])
                XCTAssertEqual(launch.dateIsTBD, expectedTBDs[index])
                XCTAssertEqual(launch.rocket, sampleRockets[index])
                XCTAssertEqual(launch.links, sampleLinks[index])
            } else {
                XCTFail("Array missing item for index: \(index)")
            }
        }
    }
}

private extension LaunchTests {
    var expectedMissionNames: [String] { ["FalconSat", "DemoSat", "Falcon 9 Test Flight"] }
    var expectedUTCDates: [String] { ["2006-03-24T22:30:00.000Z", "2007-03-21T01:10:00.000Z", "2010-06-04T18:45:00.000Z"] }
    var expectedTBDs: [Bool] { [false, false, false] }
    var expectedSuccess: [Bool] { [false, false, true] }
}
