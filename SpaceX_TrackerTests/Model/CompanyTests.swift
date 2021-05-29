//
//  CompanyTests.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import XCTest
@testable import SpaceX_Tracker

class CompanyTests: XCTestCase {
    func testDecodeJson() throws {
        let sampleCompany = try? JsonLoader.sampleCompany()
        XCTAssertNotNil(sampleCompany)
        XCTAssertEqual(sampleCompany?.name, "SpaceX")
        XCTAssertEqual(sampleCompany?.founder, "Elon Musk")
        XCTAssertEqual(sampleCompany?.foundationYear, 2002)
        XCTAssertEqual(sampleCompany?.employees, 9500)
        XCTAssertEqual(sampleCompany?.launchSites, 3)
        XCTAssertEqual(sampleCompany?.valuationUSD, 74000000000)
    }
}
