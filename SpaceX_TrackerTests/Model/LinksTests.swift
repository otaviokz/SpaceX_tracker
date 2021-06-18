//
//  LinksTests.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import XCTest
@testable import SpaceX_Tracker

class LinksTests: XCTestCase {
    func testDecodeJson() throws {
        let patches = try JsonLoader.patches()
        let links = try JsonLoader.links()
        
        XCTAssertEqual(links.map { $0.webcast?.absoluteString }, expectedWebcasts)
        XCTAssertEqual(links.map { $0.article?.absoluteString }, expectedArticles)
        XCTAssertEqual(links.map { $0.wikipedia?.absoluteString }, expectedWikipedias)
        XCTAssertEqual(links.map { $0.patch }, patches)
    }
}

private extension LinksTests {
    var expectedWebcasts: [String] {
        [
            "https://www.youtube.com/watch?v=0a_00nJ_Y88",
            "https://www.youtube.com/watch?v=Lk4zQ2wP-Nc",
            "https://www.youtube.com/watch?v=nxSxgBKlYws"
        ]
    }
    
    var expectedArticles: [String] {
        [
            "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html",
            "https://www.space.com/3590-spacex-falcon-1-rocket-fails-reach-orbit.html",
            "http://www.spacex.com/news/2013/02/12/falcon-9-flight-1"
        ]
    }
    
    var expectedWikipedias: [String] {
        [
            "https://en.wikipedia.org/wiki/DemoSat",
            "https://en.wikipedia.org/wiki/DemoSat",
            "https://en.wikipedia.org/wiki/Dragon_Spacecraft_Qualification_Unit"
        ]
    }
}
