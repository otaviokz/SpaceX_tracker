//
//  SpaceXAPIClientTests.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import XCTest
@testable import SpaceX_Tracker

class SpaceXAPIClientTests: XCTestCase {
    var mockHTTPClient = MockHTTPClient.shared
    var apiClient: SpaceXAPIClient!
    
    override func setUpWithError() throws {
        apiClient = SpaceXAPIClient(httpClient: mockHTTPClient)
    }
    
    func testParseCompany() throws {
        apiClient.company { response in
            XCTAssertNil(response.apiError)
            XCTAssertEqual(response.apiData?.name, "SpaceX")
        }
        
        mockHTTPClient.companyData = try JsonLoader.sampleCompany()
        mockHTTPClient.companyCompletion?()
    }
    
    
    func testParseLaunches() throws {
        apiClient.launches { response in
            XCTAssertNil(response.apiError)
            XCTAssertEqual(response.apiData?.documents.count, 143)
        }
        
        mockHTTPClient.launchesData = APIQueryResponse(documents: try JsonLoader.sampleLaunchesLong())
        mockHTTPClient.launchesCompletion?()
    }
}
