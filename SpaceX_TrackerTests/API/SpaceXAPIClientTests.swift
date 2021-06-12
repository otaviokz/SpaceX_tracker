//
//  SpaceXAPIClientTests.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import XCTest
@testable import SpaceX_Tracker

class SpaceXAPIClientTests: XCTestCase {
    let apiClient = SpaceXAPIClient(httpClient: MockHTTPClient.shared)
    
    override func setUpWithError() throws {
        MockHTTPClient.shared.refresh()
    }
    
    func testParseCompany() throws {
        let callback = expectation(description: "apiClient.company callback")
        MockHTTPClient.shared.companyData = try JsonLoader.sampleCompany()
        
        apiClient.company {
            XCTAssertNotNil($0.apiData)
            XCTAssertNil($0.apiError)
            callback.fulfill()
        }
        
        wait(for: [callback], timeout: 1)
    }
    
    func testPropagatesError() throws {
        let callback = expectation(description: "apiClient.company callback")
        
        apiClient.company {
            XCTAssertNil($0.apiData)
            XCTAssertEqual($0.apiError as? APIError, .invalidHTTPResponse)
            callback.fulfill()
        }
        
        wait(for: [callback], timeout: 1)
    }
    
    
    func testParseLaunches() throws {
        let callback = expectation(description: "apiClient.launches callback")
        MockHTTPClient.shared.launchesData = APIQueryResponse(documents: try JsonLoader.sampleLaunchesLong())
        
        apiClient.launches {
            XCTAssertNil($0.apiError)
            XCTAssertEqual($0.apiData?.documents.count, 143)
            callback.fulfill()
        }
        
        wait(for: [callback], timeout: 1)
    }
}
