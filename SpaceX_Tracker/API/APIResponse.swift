//
//  APIResponse.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

enum APIError: Error {
    case invalidHTTPResponse
}

struct APIResponse<T: Decodable> {
    let apiData: T?
    let apiError: Error?
}

extension APIResponse {
    static func failure(_ apiError: Error) -> APIResponse {
        APIResponse(apiData: nil, apiError: apiError)
    }
    
    static func success(_ apiData: T) -> APIResponse {
        APIResponse(apiData: apiData, apiError: nil)
    }
}
