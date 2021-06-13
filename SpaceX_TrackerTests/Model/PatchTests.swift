//
//  PatchTests.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import XCTest
@testable import SpaceX_Tracker

class PatchTests: XCTestCase {
    func testDecodeJson() throws {
        let samplePatches = try? JsonLoader.patches()
        XCTAssertNotNil(samplePatches)
        
        for index in 0...2 {
            if let patch = samplePatches?[index]  {
                XCTAssertEqual(patch.small?.absoluteString, expectedSmalls[index])
                XCTAssertEqual(patch.large?.absoluteString, expectedLarges[index])
            } else {
                XCTFail("Array missing item for index: \(index)")
            }
        }
    }
}

private extension PatchTests {
    var expectedSmalls: [String] {
        [
            "https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png",
            "https://images2.imgbox.com/4f/e3/I0lkuJ2e_o.png",
            "https://images2.imgbox.com/5c/36/gbDKf6Y7_o.png"
        ]
    }
    
    var expectedLarges: [String] {
        [
            "https://images2.imgbox.com/40/e3/GypSkayF_o.png",
            "https://images2.imgbox.com/be/e7/iNqsqVYM_o.png",
            "https://images2.imgbox.com/d6/12/yxne8mMD_o.png"
        ]
    }
}
