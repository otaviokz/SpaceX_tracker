//
//  BaseTestCase.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 06/06/2021.
//

import XCTest

extension XCTestCase {    
    func run(after: TimeInterval, block: @escaping () -> Void) {
        Timer.scheduledTimer(withTimeInterval: after, repeats: false) {_ in block() }
    }
}
