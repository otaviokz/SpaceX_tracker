//
//  SpaceX_TrackerUITests.swift
//  SpaceX_TrackerUITests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import XCTest

class MainViewControllerTests: BaseUITestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    func testBasics() throws {
        let app = XCUIApplication()
        
        XCTAssertTrue(app.navigationBars.staticTexts["SpaceX"].exists)
        
        // Assert Company info is populated correctly
        XCTAssertTrue(app.staticTexts["COMPANY"].exists)
        let text = "SpaceX was founded by Elon Musk in 2002. It has now 9500 employees, 3 launch sites, and is valued at USD 74000000000."
        let companyCell = app.tables.cells.element(matching: .cell, identifier: "CompanyCell_0_0")
        XCTAssertTrue(companyCell.exists)
        XCTAssertTrue(companyCell.staticTexts[text].exists)
        
        // Assert Company Section has only one cell
        XCTAssertFalse(app.tables.cells.element(matching: .cell, identifier: "CompanyCell_0_1").exists)
        
        
        // Assert Launches info is populated correctly
        let launchCell0 = app.tables.cells.element(matching: .cell, identifier: "LaunchCell_1_0")
        XCTAssertTrue(launchCell0.exists)
        XCTAssertTrue(launchCell0.staticTexts["Mission:"].exists)
        XCTAssertTrue(launchCell0.staticTexts["FalconSat"].exists)
        XCTAssertTrue(launchCell0.staticTexts["Date/Time:"].exists)
        XCTAssertTrue(launchCell0.staticTexts["24/03/06 at 22:30"].exists)
        XCTAssertTrue(launchCell0.staticTexts["Rocket:"].exists)
        XCTAssertTrue(launchCell0.staticTexts["Falcon 1 / rocket"].exists)
        XCTAssertTrue(launchCell0.staticTexts["Days since now:"].exists)
        
        let launchCell1 = app.tables.cells.element(matching: .cell, identifier: "LaunchCell_1_1")
        XCTAssertTrue(launchCell1.exists)
        XCTAssertTrue(launchCell1.staticTexts["Days from now:"].exists)
        
        let launchCell2 = app.tables.cells.element(matching: .cell, identifier: "LaunchCell_1_2")
        XCTAssertTrue(launchCell2.exists)
        XCTAssertTrue(launchCell2.staticTexts["Days since now:"].exists)
        
        let launchCell3 = app.tables.cells.element(matching: .cell, identifier: "LaunchCell_1_3")
        XCTAssertTrue(launchCell3.exists)
        XCTAssertTrue(launchCell3.staticTexts["Days from now:"].exists)
        
        XCTAssertFalse(app.tables.cells.element(matching: .cell, identifier: "LaunchCell_1_4").exists)
        
        XCTAssertFalse(app.tables.cells.element(matching: .image, identifier: "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png").exists)
        XCTAssertFalse(app.tables.cells.element(matching: .image, identifier: "https://images2.imgbox.com/3d/86/cnu0pan8_o.png").exists)
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
