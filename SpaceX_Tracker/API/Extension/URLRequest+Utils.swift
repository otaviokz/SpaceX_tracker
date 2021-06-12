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
    private mutating func forMethod(_ method: HTTPMethod) -> Self {
        httpMethod = method.rawValue
        return self
    }
    
    static func post(_ url: URL) -> Self {
        var request = URLRequest(url: url)
        return request.forMethod(.post)
    }
    
    static func jsonPost(_ url: URL) -> Self {
        var request = URLRequest.post(url)
        return request.settingHTTPValue("application/json", forHeader: "Content-Type")
    }
    
    static func get(_ url: URL, cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy) -> Self {
        var request = URLRequest(url: url, cachePolicy: cachePolicy)
        return request.forMethod(.get)
    }
    
    mutating func settingHTTPValue(_ value: String, forHeader: String) -> Self {
        setValue(value, forHTTPHeaderField: forHeader)
        return self
    }
}
