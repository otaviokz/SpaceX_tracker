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
        let rockets = try JsonLoader.rockets()
        let links = try JsonLoader.links()
        let launches = try JsonLoader.launches().sorted()
        
        XCTAssertEqual(launches.map { $0.missionName }, ["FalconSat", "DemoSat", "Falcon 9 Test Flight"])
        XCTAssertEqual(launches.map { $0.success }, [false, false, true])
        XCTAssertEqual(launches.map { $0.dateUTC }, ["2006-03-24T22:30:00.000Z", "2007-03-21T01:10:00.000Z", "2010-06-04T18:45:00.000Z"])
        XCTAssertEqual(launches.map { $0.dateIsTBD }, [false, false, false])
        XCTAssertEqual(launches.map { $0.rocket }, rockets)
        XCTAssertEqual(launches.map { $0.links }, links)
    }
}
