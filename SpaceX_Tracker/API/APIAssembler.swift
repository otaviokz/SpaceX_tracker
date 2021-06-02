//
//  APIAssembler.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import Foundation

struct APIAssembler {
    
    static var httpClient: HTTPClientType {
        RuntimeService.isRunningTests ? MockHTTPClient.shared : HTTPClient.shared
    }
    
    static var apiClient: SpaceXAPIClientType {
        RuntimeService.isRunningTests ? MockAPIClient.shared : SpaceXAPIClient(httpClient: httpClient)
    }
}
