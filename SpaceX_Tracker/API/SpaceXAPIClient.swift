//
//  SpaceXAPI.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import Foundation

typealias CompanyCompletion = APICompletion<Company>
typealias LaunchesCompletion = APICompletion<APIQueryResponse<[Launch]>>

protocol SpaceXAPIClientType {
    func launches(_ completion: @escaping LaunchesCompletion)
    func company(_ completion: @escaping CompanyCompletion)
}

struct SpaceXAPIClient: SpaceXAPIClientType {
    private let httpClient: HTTPClientType
    private let baseURL: URL
    private var launchesURL: URL { baseURL.appendingPathComponent("launches/query") }
    private var companyURL: URL { baseURL.appendingPathComponent("company") }
    private let queue = OperationQueue()
    
    init(baseURL: URL = URL(string: "https://api.spacexdata.com/v4")!, httpClient: HTTPClientType) {
        self.baseURL = baseURL
        self.httpClient = httpClient
        queue.maxConcurrentOperationCount = 1
    }
    
    func launches(_ completion: @escaping LaunchesCompletion) {
        queue.addOperation {
            httpClient.post(url: launchesURL, body: launchQuery(), completion: completion)
        }
    }
    
    func company(_ completion: @escaping CompanyCompletion) {
        queue.addOperation {
            httpClient.get(url: companyURL, completion: completion)
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
