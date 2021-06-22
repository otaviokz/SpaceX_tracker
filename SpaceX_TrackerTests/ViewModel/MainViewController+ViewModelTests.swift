//
//  MainViewController+ViewModelTests.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 10/06/2021.
//

import XCTest
@testable import SpaceX_Tracker

class MainViewControllerViewModelTests: XCTestCase {
    var viewModel: MainViewController.ViewModel!
    var launches: [Launch]!
    var httpClient: HTTPClientType!
    
    override func setUpWithError() throws {
        httpClient = MockHTTPClient(company: try! JsonLoader.company(), launches:  try! JsonLoader.launches())
        viewModel = .init(apiClient: SpaceXAPIClient(httpClient: httpClient))
        viewModel.fetchData()
        launches = try JsonLoader.launches()
    }
    
    func testPopulateAllYears() throws {
        XCTAssertEqual(viewModel.availableYears, [2006, 2007, 2010])
    }
    
    func testSort() {
        XCTAssertEqual(viewModel.launches, launches)
        viewModel.toggleSort()
        XCTAssertEqual(viewModel.launches, launches.reversed())
    }
    
    func testFilter() {
        viewModel.filterOptions.checkedYears = Set([2006, 2007, 2010])
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 3)
        
        viewModel.filterOptions.checkedYears = Set([])
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 3)
        
        viewModel.filterOptions.checkedYears = Set([2006, 2010])
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 2)
        
        viewModel.filterOptions.checkedYears = Set([2006])
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 1)
        
        viewModel.filterOptions.checkedYears = Set([2006, 2007, 2010])
        viewModel.filterOptions.success = true
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 1)
        viewModel.filterAndSort()
        viewModel.filterOptions.checkedYears = Set([2006, 2007])
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 0)
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            let years = Array(2000...2050)
            let checkedYears = Set([2000, 2005, 2010, 2015, 2020, 2025, 2030, 2035, 2040, 2045, 2050])
            viewModel.filterOptions.years = years
            viewModel.filterOptions.checkedYears = checkedYears
            measure(options: .default) {
                for _ in 0...10000 {
                    viewModel.filterOptions.checkedYears = checkedYears
                    viewModel.filterOptions.years = years
                    viewModel.filterAndSort()
                }
            }
        }
    }
}
