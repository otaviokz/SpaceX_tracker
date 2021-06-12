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
        XCTAssertTrue(app.staticTexts["LAUNCHES"].exists)
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "Mission:")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "DART")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "Date/Time:")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "11/23/99 at 00:00")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "Rocket:")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "Falcon 9 / rocket")
        
        // Assert correct nomber os launch cells are populated
        XCTAssertTrue(app.tableCell(identifier: "LaunchCell_1_146").exists)
        XCTAssertFalse(app.tableCell(identifier: "LaunchCell_1_147").exists)
    }
    
    func testShowLinks() throws {
        XCTAssertTrue(app.navigationBars.staticTexts["SpaceX"].waitForExistence(timeout: 1))
        
        app.tableCell(identifier: "LaunchCell_1_0").tap()
        XCTAssertFalse(app.sheets.buttons["Cancel"].exists)

        app.tableCell(identifier: "LaunchCell_1_8").tap()
        XCTAssertTrue(app.sheets.buttons["Wikipedia"].exists)
        XCTAssertFalse(app.sheets.buttons["Webcast"].exists)
        XCTAssertFalse(app.sheets.buttons["Article"].exists)
        app.sheets.buttons["Cancel"].tap()
        
        app.tableCell(identifier: "LaunchCell_1_21").tap()
        XCTAssertTrue(app.sheets.buttons["Wikipedia"].exists)
        XCTAssertTrue(app.sheets.buttons["Webcast"].exists)
        XCTAssertTrue(app.sheets.buttons["Article"].exists)
    }
    
    func testSort() {
        XCTAssertTrue(app.navigationBars.staticTexts["SpaceX"].waitForExistence(timeout: 1))
        
        app.buttons["SortButton"].tap()
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "03/24/06 at 22:30")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "Days since now:")
        
        app.buttons["SortButton"].tap()
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "11/23/99 at 00:00")
        app.verifyTableCell(identifier: "LaunchCell_1_0", staticText: "Days from now:")
    }
    
    func testFilter() {
        XCTAssertTrue(app.navigationBars.staticTexts["SpaceX"].waitForExistence(timeout: 1))
        app.buttons["FilterButton"].tap()
        
        XCTAssertTrue(app.navigationBars.staticTexts["Filter by:"].waitForExistence(timeout: 1))
        XCTAssertTrue(app.staticTexts["Status"].exists)
        app.verifyTableCell(identifier: "FilterCell_0_0", staticText: "Successfull")
        app.tableCell(identifier: "FilterCell_0_0").tap()
        
        XCTAssertTrue(app.staticTexts["Years"].exists)
        app.verifyTableCell(identifier: "FilterCell_1_0", staticText: "2006")
        app.verifyTableCell(identifier: "FilterCell_1_17", staticText: "2099")
        app.tableCell(identifier: "FilterCell_1_0").tap()
        app.navigationBars.buttons["Save"].tap()
        
        app.buttons["FilterButton"].tap()
        XCTAssertTrue(app.tableCell(identifier: "FilterCell_0_0_selected").waitForExistence(timeout: 1))
        XCTAssertTrue(app.tableCell(identifier: "FilterCell_1_0_selected").waitForExistence(timeout: 1))
        app.tableCell(identifier: "FilterCell_1_0_selected").tap()
        app.navigationBars.buttons["Reset"].tap()
        
        app.buttons["FilterButton"].tap()
        XCTAssertTrue(app.tableCell(identifier: "FilterCell_0_0").waitForExistence(timeout: 1))
        XCTAssertTrue(app.tableCell(identifier: "FilterCell_1_0").waitForExistence(timeout: 1))
        app.navigationBars.buttons["Cancel"].tap()
    }
}
