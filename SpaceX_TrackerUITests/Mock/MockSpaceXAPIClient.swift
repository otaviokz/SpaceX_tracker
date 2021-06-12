//
//  MockSpaceXAPIClient.swift
//  SpaceX_TrackerUITests
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import Foundation

class MockAPIClient: SpaceXAPIClientType {
    static let shared = MockAPIClient()
    
    private init() {
        MockHTTPClient.shared.companyData = try! JsonLoader.sampleCompany()
        MockHTTPClient.shared.launchesData = APIQueryResponse(documents: try! JsonLoader.sampleLaunches())
    }

    func company(_ completion: @escaping (APIResponse<Company>) -> Void) {
        MockHTTPClient.shared.get(url: URL(string: "www.google.com")!, completion: completion)
    }
    
    func launches(_ completion: @escaping LaunchesCompletion) {
        MockHTTPClient.shared.post(url: URL(string: "www.google.com")!, body: [:], completion: completion)
    }
}
