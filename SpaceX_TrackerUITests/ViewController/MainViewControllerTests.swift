//
//  SpaceX_TrackerUITests.swift
//  SpaceX_TrackerUITests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import XCTest

class MainViewControllerTests: BaseUITestCase {
    func testBasics() throws {
        XCTAssertTrue(app.navigationBars.staticTexts["SpaceX"].exists)
        
        // Assert company info is populated correctly
        XCTAssertTrue(app.staticTexts[.main_company].exists)
        let text = "SpaceX was founded by Elon Musk in 2002. It has now 9500 employees, 3 launch sites, and is valued at USD 74000000000."
        app.verifyTableCell("CompanyCell_0_0", text: text)

        // Assert launches info is populated correctly
        XCTAssertTrue(app.staticTexts[.main_launches].exists)
        app.verifyTableCell("LaunchCell_1_0", textKey: .main_mission)
        app.verifyTableCell("LaunchCell_1_0", text: "DART")
        app.verifyTableCell("LaunchCell_1_0", textKey: .main_date)
        app.verifyTableCell("LaunchCell_1_0", text: "11/23/99 at 00:00")
        app.verifyTableCell("LaunchCell_1_0", textKey: .main_rocket)
        app.verifyTableCell("LaunchCell_1_0", text: "Falcon 9 / rocket")
        
        // Assert correct nomber os launch cells are populated
        XCTAssertTrue(app.tableCell("LaunchCell_1_146").exists)
        XCTAssertFalse(app.tableCell("LaunchCell_1_147").exists)
    }
    
    func testShowLinks() throws {
        app.tableCell("LaunchCell_1_0").tap()
        XCTAssertFalse(app.sheets.buttons[.main_cancel].exists)
        
        app.tableCell("LaunchCell_1_21").tap()
        XCTAssertEqual(app.sheets.buttons.count, 4)
        XCTAssertTrue(app.sheets.buttons[.main_wiki].exists)
        XCTAssertTrue(app.sheets.buttons[.main_webcast].exists)
        XCTAssertTrue(app.sheets.buttons[.main_article].exists)
        app.sheets.buttons[.main_cancel].tap()
    }
    
    func testSort() {
        app.buttons["SortButton"].tap()
        app.verifyTableCell("LaunchCell_1_0", text: "03/24/06 at 22:30")
        app.verifyTableCell("LaunchCell_1_0", textKey: .main_days_since)
        
        app.buttons["SortButton"].tap()
        app.verifyTableCell("LaunchCell_1_0", text: "11/23/99 at 00:00")
        app.verifyTableCell("LaunchCell_1_0", textKey: .main_days_from)
    }
    
    func testFilter() {
        app.buttons["FilterButton"].tap()
        XCTAssertTrue(app.navigationBars.staticTexts[.filter_title].exists)
        XCTAssertTrue(app.staticTexts[.filter_status].exists)
        app.verifyTableCell("FilterCell_0_0", textKey: .filter_success)
        app.tableCell("FilterCell_0_0").tap()
        
        XCTAssertTrue(app.staticTexts[.filter_years].exists)
        app.verifyTableCell("FilterCell_1_0", text: "2006")
        app.verifyTableCell("FilterCell_1_17", text: "2099")
        app.tableCell("FilterCell_1_0").tap()
        
        app.navigationBars.buttons["Done"].tap()
        app.buttons["FilterButton"].tap()
        XCTAssertTrue(app.tableCell("FilterCell_0_0_selected").exists)
        XCTAssertTrue(app.tableCell("FilterCell_1_0_selected").exists)
        app.tableCell("FilterCell_1_0_selected").tap()
        app.navigationBars.buttons["Reset"].tap()
        
        app.buttons["FilterButton"].tap()
        XCTAssertTrue(app.tableCell("FilterCell_0_0").exists)
        XCTAssertTrue(app.tableCell("FilterCell_1_0").exists)
    }
}
