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
    private var httpClient: HTTPClientType
    private var baseURL: URL = URL(string: "https://api.spacexdata.com/v4")!
    private var launchesURL: URL { baseURL.appendingPathComponent("launches/query") }
    private var companyURL: URL { baseURL.appendingPathComponent("company") }
    
    init(baseURL: URL = URL(string: "https://api.spacexdata.com/v4")!, httpClient: HTTPClientType) {
        self.baseURL = baseURL
        self.httpClient = httpClient
    }
    
    func launches(_ completion: @escaping LaunchesCompletion) {
        httpClient.post(url: launchesURL, body: launchQuery(), completion: completion)
    }
    
    func company(_ completion: @escaping CompanyCompletion) {
        httpClient.get(url: companyURL, completion: completion)
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
