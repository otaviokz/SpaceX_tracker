//
//  HTTPClient.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

import Foundation

typealias APICompletion<T: Decodable> = (APIResponse<T>) -> Void
typealias DataCompletion<T: Decodable> = (DataResponse<T>) -> Void

protocol HTTPClientType {
    func get<T: Decodable>(url: URL, completion: @escaping APICompletion<T>)
    func getData(url: URL, cachePolicy: NSURLRequest.CachePolicy, completion: @escaping DataCompletion<Data>)
    func post<T: Decodable>(url: URL, body: [String: Any], completion: @escaping APICompletion<T>)
}

struct HTTPClient: HTTPClientType {
    static let shared = HTTPClient()
    private init() {}
    
    func get<T: Decodable>(url: URL, completion: @escaping APICompletion<T>) {
        URLSession.shared.dataTask(with: .get(url)) {
            parseJSON($0, $2, completion)
        }.resume()
    }
    
    func getData(url: URL, cachePolicy: NSURLRequest.CachePolicy, completion: @escaping DataCompletion<Data>) {
        URLSession.shared.dataTask(with: .get(url, cachePolicy: cachePolicy)) {
            if let data = $0 {
                completion(.success(data))
            } else {
                completion(.failure($2 ?? APIError.invalidHTTPResponse))
            }
        }.resume()
    }
    
    func post<T: Decodable>(url: URL, body: [String: Any], completion: @escaping APICompletion<T>) {
        do {
            URLSession.shared.uploadTask(with: .jsonPost(url), from: try body.jsData()) {
                parseJSON($0, $2, completion)
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    private func parseJSON<T: Decodable>(_ data: Data?, _ error: Error?, _ completion: @escaping APICompletion<T>) {
        do {
            if let data = data {
                completion(.success(try JSONDecoder().decode(T.self, from: data)))
            } else {
                completion(.failure(error ?? APIError.invalidHTTPResponse))
            }
        } catch {
            completion(.failure(error))
        }
    }
}

private extension Dictionary where Key == String {
    func jsData() throws -> Data {
        try JSONSerialization.data(withJSONObject: self)
    }
}

