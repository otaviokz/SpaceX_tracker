//
//  SpaceX_TrackerUITests.swift
//  SpaceX_TrackerUITests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import XCTest

class MainViewControllerTests: BaseUITestCase {
    func testBasics() throws {
        XCTAssertTrue(app.navigationBars.staticTexts["SpaceX"].waitForExistence(timeout: 1))
        
        // Assert company info is populated correctly
        XCTAssertTrue(app.staticTexts["COMPANY"].exists)
        let text = "SpaceX was founded by Elon Musk in 2002. It has now 9500 employees, 3 launch sites, and is valued at USD 74000000000."
        app.verifyTableCell(identifier: "CompanyCell_0_0", staticText: text)

        // Assert launches info is populated correctly
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "Mission:")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "FalconSat")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "Date/Time:")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "03/24/06 at 22:30")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "Rocket:")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "Falcon 1 / rocket")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "Days since now:")

        // Assert next 3 launch cells is have correct description for past/future date
        app.verifyTableCell(identifier: "LaunchCell_1_1", staticText: "Days from now:")
        app.verifyTableCell(identifier: "LaunchCell_1_2", staticText: "Days since now:")
        app.verifyTableCell(identifier: "LaunchCell_1_3", staticText: "Days from now:")
        
        // Assert correct nomber os launch cells are populated
        XCTAssertTrue(app.tableCell(identifier: "LaunchCell_1_146").exists)
        XCTAssertFalse(app.tableCell(identifier: "LaunchCell_1_147").exists)
        
    }
    
    func testShowLinks() throws {
        XCTAssertTrue(app.navigationBars.staticTexts["SpaceX"].waitForExistence(timeout: 1))
        
        app.tableCell(identifier: "LaunchCell_1_0").tap()
        XCTAssertTrue(app.sheets.buttons["Wikipedia"].exists)
        XCTAssertTrue(app.sheets.buttons["Webcast"].exists)
        XCTAssertTrue(app.sheets.buttons["Article"].exists)
        app.sheets.buttons["Cancel"].tap()
        
        app.tableCell(identifier: "LaunchCell_1_1").tap()
        XCTAssertFalse(app.sheets.buttons["Cancel"].exists)

        app.tableCell(identifier: "LaunchCell_1_10").tap()
        XCTAssertTrue(app.sheets.buttons["Wikipedia"].exists)
        XCTAssertFalse(app.sheets.buttons["Webcast"].exists)
        XCTAssertFalse(app.sheets.buttons["Article"].exists)
    }
}
