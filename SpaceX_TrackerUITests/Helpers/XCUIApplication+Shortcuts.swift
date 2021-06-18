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
    
    func verifyTableCell(_ identifier: String, textKey: LocalizationKey, exists: Bool = true) {
        XCTAssertEqual(tableCell(identifier).staticTexts[textKey].exists, exists)
    }
    
    func verifyTableCell(_ identifier: String, text: String, exists: Bool = true) {
        XCTAssertEqual(tableCell(identifier).staticTexts[text].exists, exists)
    }
}

extension XCUIElementQuery {
    subscript(_ key: LocalizationKey) -> XCUIElement {
        self[localize(key, bundle: Bundle(for: BaseUITestCase.self))]
    }
}
