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
        var response: APIResponse<Company>?
        MockHTTPClient.shared.companyData = try JsonLoader.sampleCompany()
        
        apiClient.company {
            response = $0
            callback.fulfill()
        }
        
        run(after: 0.1) { MockHTTPClient.shared.companyCompletion?() }
        wait(for: [callback], timeout: 1)
        
        XCTAssertNotNil(response?.apiData)
        XCTAssertNil(response?.apiError)
    }
    
    func testPropagatesError() throws {
        let callback = expectation(description: "apiClient.company callback")
        var response: APIResponse<Company>?
        
        apiClient.company {
            response = $0
            callback.fulfill()
        }
        
        run(after: 0.1) { MockHTTPClient.shared.companyCompletion?() }
        wait(for: [callback], timeout: 1)
        
        XCTAssertNil(response?.apiData)
        XCTAssertEqual(response?.apiError as? APIError, .invalidHTTPResponse)
    }
    
    
    func testParseLaunches() throws {
        let callback = expectation(description: "apiClient.launches callback")
        var response: APIResponse<APIQueryResponse<[Launch]>>?
        MockHTTPClient.shared.launchesData = APIQueryResponse(documents: try JsonLoader.sampleLaunchesLong())
        
        apiClient.launches {
            response = $0
            callback.fulfill()
        }
        
        run(after: 0.1) { MockHTTPClient.shared.launchesCompletion?() }
        wait(for: [callback], timeout: 1)
        
        XCTAssertNil(response?.apiError)
        XCTAssertEqual(response?.apiData?.documents.count, 143)
    }
}
