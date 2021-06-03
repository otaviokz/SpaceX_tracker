//
//  XCUIApplication+Shortcuts.swift
//  SpaceX_TrackerUITests
//
//  Created by Otávio Zabaleta on 03/06/2021.
//

import XCTest

extension XCUIApplication {
    func verifyTableCell(identifier: String, staticText: String? = nil, exists: Bool = true) {
        let cell = tables.cells.element(matching: .cell, identifier: identifier)
        if let staticText = staticText {
            XCTAssertEqual(cell.staticTexts[staticText].exists, exists)
        } else {
            XCTAssertEqual(cell.exists, exists)
        }
    }
    
    func tableCell(identifier: String) -> XCUIElement {
        tables.cells.element(matching: .cell, identifier: identifier)
    }
}
