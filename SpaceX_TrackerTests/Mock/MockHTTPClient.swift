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
    var companyData: Company?
    var launchesData: QueryResult<[Launch]>?
    var expectaion: Any?
    
    private init() {
        companyData = try! JsonLoader.company()
        launchesData = QueryResult(try! JsonLoader.launches())
    }
        
    func getImage(_ url: URL, cachePolicy: NSURLRequest.CachePolicy) -> AnyPublisher<UIImage, APIError> {
        guard let image = Images.badgePlaceholder else { return Fail(error: .httpError).eraseToAnyPublisher() }
        return Just(image).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
    
    func get<T: Decodable>(_ url: URL) -> AnyPublisher<T, APIError> {
        guard let data = companyData as? T else { return Fail(error: .httpError).eraseToAnyPublisher() }
        return Just(data).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
    
    func postJSON<T: Decodable>(_ url: URL, body: Data) -> AnyPublisher<T, APIError> {
        guard let data = launchesData as? T else { return Fail(error: .httpError).eraseToAnyPublisher() }
        return Just(data).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
}
