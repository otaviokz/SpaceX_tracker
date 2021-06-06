//
//  MockSpaceXAPIClient.swift
//  SpaceX_TrackerUITests
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import Foundation

class MockAPIClient: SpaceXAPIClientType {
    static let shared = MockAPIClient()
    
    var companyResponse : APIResponse<Company>
    var launchesResponse: APIResponse<APIQueryResponse<[Launch]>>
    
    private init() {
        companyResponse = .success(try! JsonLoader.sampleCompany())
        launchesResponse = .success(APIQueryResponse(documents: try! JsonLoader.sampleLaunches()))
    }

    func company(_ completion: @escaping (APIResponse<Company>) -> Void) {
        completion(companyResponse)
    }
    
    
    func launches(_ completion: @escaping LaunchesCompletion) {
        completion(launchesResponse)
    }
}
