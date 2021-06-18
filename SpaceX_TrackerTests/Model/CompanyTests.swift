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
        let company = try JsonLoader.company()
        
        XCTAssertEqual(company.name, "SpaceX")
        XCTAssertEqual(company.founder, "Elon Musk")
        XCTAssertEqual(company.foundationYear, 2002)
        XCTAssertEqual(company.employees, 9500)
        XCTAssertEqual(company.launchSites, 3)
        XCTAssertEqual(company.valuationUSD, 74000000000)
    }
}
