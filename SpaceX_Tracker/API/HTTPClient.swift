//
//  HTTPClient.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

import Combine
import UIKit

protocol HTTPClientType {
    func getImage(_ url: URL, cachePolicy: NSURLRequest.CachePolicy) -> AnyPublisher<UIImage, APIError>
    func get<T: Decodable>(_ url: URL) -> AnyPublisher<T, APIError>
    func postJSON<T: Decodable>(_ url: URL, body: Data) -> AnyPublisher<T, APIError>
}

struct HTTPClient: HTTPClientType {
    static let shared = HTTPClient()
    private init() {}
    
    func getImage(_ url: URL, cachePolicy: NSURLRequest.CachePolicy) -> AnyPublisher<UIImage, APIError> {
        connect(.get(url, cachePolicy: cachePolicy))
    }
    
    func get<T: Decodable>(_ url: URL) -> AnyPublisher<T, APIError> {
        connect(.get(url))
    }
    
    func postJSON<T: Decodable>(_ url: URL, body: Data) -> AnyPublisher<T, APIError> {
        connect(.postJSON(body, to: url))
    }
    
    private func connect<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, APIError> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                guard ($0.response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.httpError }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { .map($0) }
            .eraseToAnyPublisher()
    }
    
    private func connect(_ request: URLRequest) -> AnyPublisher<UIImage, APIError> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                guard let image = UIImage(data: $0.data) else { throw APIError.invalidData }
                return image
            }
            .mapError { .map($0) }
            .eraseToAnyPublisher()
    }
}
