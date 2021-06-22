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
    private func forMethod(_ method: HTTPMethod) -> Self {
        var request = self
        request.httpMethod = method.rawValue
        return request
    }
    
    static func post(_ url: URL) -> Self {
        URLRequest(url: url).forMethod(.post)
    }
    
    static func json(_ url: URL) -> Self {
        URLRequest.post(url).settingHTTPValue("application/json", forHeader: "Content-Type")
    }
    
    static func get(_ url: URL, cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy) -> Self {
        URLRequest(url: url, cachePolicy: cachePolicy).forMethod(.get)
    }
    
    func settingHTTPValue(_ value: String, forHeader: String) -> Self {
        var request = self
        request.setValue(value, forHTTPHeaderField: forHeader)
        return request
    }
}
