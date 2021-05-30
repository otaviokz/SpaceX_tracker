//
//  BaseUITestCasse.swift
//  SpaceX_TrackerUITests
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

import XCTest

class BaseUITestCase: XCTestCase {
    override func setUpWithError() throws {
        let app = XCUIApplication()
        app.launchEnvironment.updateValue("YES", forKey: "UITesting")
        app.launchArguments += ProcessInfo().arguments
        app.launch()
    }
}
