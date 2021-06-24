//
//  URLRequest+Utils.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

extension URLRequest {
    private func method(_ method: HTTPMethod) -> URLRequest {
        var request = self
        request.httpMethod = method.rawValue
        return request
    }
    
    static func post(_ url: URL) -> URLRequest {
        URLRequest(url: url).method(.post)
    }
    
    static func json(_ url: URL) -> URLRequest {
        var request = URLRequest.post(url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    static func get(_ url: URL, cachePolicy: CachePolicy = .useProtocolCachePolicy) -> URLRequest {
        URLRequest(url: url, cachePolicy: cachePolicy).method(.get)
    }
}
