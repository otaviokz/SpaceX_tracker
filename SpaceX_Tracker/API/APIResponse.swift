//
//  APIResponse.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

enum APIError: Error {
    case notAbleToDecodeData
    case notHttpResponse
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

struct APIQueryResponse<T: Decodable>: Decodable {
    let documents: T
    let totalDocs: Int
    let limit: Int
    let totalPages: Int
    let page: Int
    let nextPage: Int?
    
    init(documents: T) {
        self.documents = documents
        totalDocs = 0
        limit = 0
        totalPages = 0
        page = 0
        nextPage = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case totalDocs, limit, totalPages, page, nextPage
        case documents = "docs"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: APIQueryResponse.CodingKeys.self)
        documents = try container.decode(T.self, forKey: .documents)
        totalDocs = try container.decode(Int.self, forKey: .totalDocs)
        limit = try container.decode(Int.self, forKey: .limit)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        page = try container.decode(Int.self, forKey: .page)
        nextPage = try container.decodeIfPresent(Int.self, forKey: .nextPage)
    }
}
