//
//  MainViewController+ViewModelTests.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 10/06/2021.
//

import XCTest
@testable import SpaceX_Tracker

class FilterOptionsTests: XCTestCase {
    var filterOptions: FilterOptions!
    var launches: [Launch]!
    
    override func setUpWithError() throws {
        filterOptions = FilterOptions()
        launches = try JsonLoader.launches()
        filterOptions.update(for: launches)
    }
    
    func testPopulateAllYears() throws {
        XCTAssertEqual(filterOptions.years, [2006, 2007, 2010])
    }
    
    func testSort() {
        XCTAssertEqual(filterOptions.filter(launches), launches)
        XCTAssertEqual(filterOptions.filter(launches, sortAscending: true), launches.reversed())
    }

    func testFilter() {
        filterOptions.checkedYears = Set([2006, 2007, 2010])
        XCTAssertEqual(filterOptions.filter(launches).count, 3)

        filterOptions.checkedYears = Set([])
        XCTAssertEqual(filterOptions.filter(launches).count, 3)

        filterOptions.checkedYears = Set([2006, 2010])
        XCTAssertEqual(filterOptions.filter(launches).count, 2)

        filterOptions.checkedYears = Set([2006])
        XCTAssertEqual(filterOptions.filter(launches).count, 1)

        filterOptions.checkedYears = Set([2006, 2007, 2010])
        filterOptions.success = true
        XCTAssertEqual(filterOptions.filter(launches).count, 1)

        filterOptions.checkedYears = Set([2006, 2007])
        XCTAssertEqual(filterOptions.filter(launches).count, 0)
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            let years = Array(2000...2050)
            let checkedYears = Set([2000, 2005, 2010, 2015, 2020, 2025, 2030, 2035, 2040, 2045, 2050])
            filterOptions.years = years
            filterOptions.checkedYears = checkedYears
            measure(options: .default) {
                for index in 0...10000 {
                    filterOptions.checkedYears = checkedYears
                    filterOptions.years = years
                    _ = filterOptions.filter(launches, sortAscending: index % 2 == 0)
                }
            }
        }
    }
}
