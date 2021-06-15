//
//  XCUIApplication+Shortcuts.swift
//  SpaceX_TrackerUITests
//
//  Created by Otávio Zabaleta on 03/06/2021.
//

import XCTest

extension XCUIApplication {
    func tableCell(_ identifier: String) -> XCUIElement {
        tables.cells.element(matching: .cell, identifier: identifier)
    }
    
    func verifyTableCell(_ identifier: String, staticKey: LocalizationKey? = nil, exists: Bool = true) {
        let cell = tableCell(identifier)
        if let staticKey = staticKey {
            XCTAssertEqual(cell.staticTexts[staticKey].exists, exists)
        } else {
            XCTAssertEqual(cell.exists, exists)
        }
    }
    
    func verifyTableCell(_ identifier: String, staticText: String? = nil, exists: Bool = true) {
        let cell = tableCell(identifier)
        if let staticText = staticText {
            XCTAssertEqual(cell.staticTexts[staticText].exists, exists)
        } else {
            XCTAssertEqual(cell.exists, exists)
        }
    }
}

extension XCUIElementQuery {
    subscript(_ key: LocalizationKey) -> XCUIElement {
        self[localize(key, bundle: Bundle(for: BaseUITestCase.self))]
    }
}
