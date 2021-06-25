//
//  SpaceXAPI.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import Foundation
import Combine

struct SpaceXAPIClient {
    private let httpClient: HTTPClientType
    private let baseURL: URL
    private var launchesURL: URL { baseURL.appendingPathComponent("launches/query") }
    private var companyURL: URL { baseURL.appendingPathComponent("company") }
    
    init(baseURL: URL = URL(string: "https://api.spacexdata.com/v4")!, httpClient: HTTPClientType) {
        self.baseURL = baseURL
        self.httpClient = httpClient
    }
    
    func company() -> AnyPublisher<Company, APIError> {
        httpClient.get(companyURL)
    }
    
    func launches(page: Int = 0, limit: Int = 200) -> AnyPublisher<APIQueryResponse<[Launch]>, APIError>  {
        do {
            return httpClient.postJSON(launchesURL, body: try launchQuery().json())
        } catch {
            return Fail(error: .map(error)).eraseToAnyPublisher()
        }
    }
}

private extension SpaceXAPIClient {
    func launchQuery(page: Int = 0, limit: Int = 200) -> [String: Any] {
        [
            "options": [
                "populate": [
                    "path": "rocket",
                    "select": [
                        "name": 1,
                        "type" : 1
                    ]
                ],
                "limit": limit,
                "page": page,
                "sort": ["date_utc": "desc"],
                "select": [
                    "name", "date_utc", "tbd", "success", "rocket", "links.patch", "links.wikipedia", "links.webcast", "links.article"
                ]
            ]
        ]
    }
}

extension Dictionary where Key == String {
    func json() throws -> Data {
        try JSONSerialization.data(withJSONObject: self)
    }
}

