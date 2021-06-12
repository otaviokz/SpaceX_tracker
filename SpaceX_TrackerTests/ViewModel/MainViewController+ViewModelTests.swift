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
    
    override func setUpWithError() throws {
        viewModel = .init(imageLoader: ImageLoader.shared, apiClient: MockAPIClient.shared)
        viewModel.launches = try JsonLoader.sampleLaunches()
        launches = try JsonLoader.sampleLaunches().reversed()
        
    }
    
    func testPopulateAllYears() throws {
        XCTAssertEqual(viewModel.availableYears, [2006, 2007, 2010])
    }
    
    func testSort() {
        XCTAssertEqual(viewModel.filteredLaunches, launches)
        viewModel.toggleSort()
        XCTAssertEqual(viewModel.filteredLaunches, launches.reversed())
    }
    
    func testFilter() {
        viewModel.filterOptions.checkedYears = [2006, 2007, 2010]
        XCTAssertEqual(viewModel.filteredLaunches.count, 3)
        
        
        viewModel.filterOptions.checkedYears = []
        XCTAssertEqual(viewModel.filteredLaunches.count, 3)
        
        viewModel.filterOptions.checkedYears = [2006, 2010]
        XCTAssertEqual(viewModel.filteredLaunches.count, 2)
        
        viewModel.filterOptions.checkedYears = [2006]
        XCTAssertEqual(viewModel.filteredLaunches.count, 1)
        
        viewModel.filterOptions.checkedYears = [2006, 2007, 2010]
        viewModel.filterOptions.success = true
        XCTAssertEqual(viewModel.filteredLaunches.count, 1)
        viewModel.filterOptions.checkedYears = [2007]
        XCTAssertEqual(viewModel.filteredLaunches.count, 0)
    }
}
