//
//  BaseUITestCasse.swift
//  SpaceX_TrackerUITests
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

import XCTest

class BaseUITestCase: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launchEnvironment.updateValue("YES", forKey: "UITesting")
        app.launchArguments += ProcessInfo().arguments
        app.launchArguments += ["-AppleLanguages", "(en)"]
        app.launchArguments += ["-AppleLocale", "en_US"]
        app.launch()
    }
}
