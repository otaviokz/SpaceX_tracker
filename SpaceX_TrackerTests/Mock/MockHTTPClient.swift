//
//  MockSpaceXAPIClient.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit
import Combine

class MockHTTPClient: HTTPClientType {
    static var shared = MockHTTPClient()
    
    var company: Company?
    var launches: [Launch]?
    private var launchesQuery: QueryResult<[Launch]>? {
        guard let launches = launches else { return nil }
        return QueryResult(launches)
    }
    
    private init() {
        company = try! JsonLoader.company()
        launches = try! JsonLoader.launches()
    }
        
    func getImage(_ url: URL, cachePolicy: NSURLRequest.CachePolicy) -> AnyPublisher<UIImage, APIError> {
        guard let data = Images.badgePlaceholder else { return Fail(error: .httpError).eraseToAnyPublisher() }
        return Just(data).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
    
    func get<T: Decodable>(_ url: URL) -> AnyPublisher<T, APIError> {
        guard let data = company as? T else { return Fail(error: .httpError).eraseToAnyPublisher() }
        return Just(data).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
    
    func postJSON<T: Decodable>(_ url: URL, body: Data) -> AnyPublisher<T, APIError> {
        guard  let data = launchesQuery as? T else { return Fail(error: .httpError).eraseToAnyPublisher() }
        return Just(data).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
}
