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
        viewModel.filterOptions.checkedYears = [2006, 2007, 2010]
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 3)
        
        viewModel.filterOptions.checkedYears = []
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 3)
        
        viewModel.filterOptions.checkedYears = [2006, 2010]
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 2)
        
        viewModel.filterOptions.checkedYears = [2006]
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 1)
        
        viewModel.filterOptions.checkedYears = [2006, 2007, 2010]
        viewModel.filterOptions.success = true
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 1)
        viewModel.filterAndSort()
        viewModel.filterOptions.checkedYears = [2006, 2007]
        viewModel.filterAndSort()
        XCTAssertEqual(viewModel.launches.count, 0)
    }
}
