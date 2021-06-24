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
    func getData(_ url: URL, cachePolicy: NSURLRequest.CachePolicy, completion: @escaping DataCompletion<Data>)
    func get<T: Decodable>(_ url: URL, completion: @escaping APICompletion<T>)
    func postJSON<T: Decodable>(_ url: URL, body: [String: Any], completion: @escaping APICompletion<T>)
}

struct HTTPClient: HTTPClientType {
    static let shared = HTTPClient()
    private init() {}
    
    func getData(_ url: URL, cachePolicy: NSURLRequest.CachePolicy, completion: @escaping DataCompletion<Data>) {
        URLSession.shared.dataTask(with: .get(url, cachePolicy: cachePolicy)) {
            if let data = $0 {
                completion(.success(data))
            } else {
                completion(.failure($2 ?? APIError.invalidHTTPResponse))
            }
        }.resume()
    }
    
    func get<T: Decodable>(_ url: URL, completion: @escaping APICompletion<T>) {
        URLSession.shared.dataTask(with: .get(url)) { parse($0, $2, completion) }.resume()
    }
    
    func postJSON<T: Decodable>(_ url: URL, body: [String: Any], completion: @escaping APICompletion<T>) {
        do {
            URLSession.shared.uploadTask(with: .json(url), from: try body.json()) { parse($0, $2, completion) }.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    private func parse<T: Decodable>(_ jsonData: Data?, _ error: Error?, _ completion: @escaping APICompletion<T>) {
        do {
            if let jsonData = jsonData {
                completion(.success(try JSONDecoder().decode(T.self, from: jsonData)))
            } else {
                completion(.failure(error ?? APIError.invalidHTTPResponse))
            }
        } catch {
            completion(.failure(error))
        }
    }
}

private extension Dictionary where Key == String {
    func json() throws -> Data { try JSONSerialization.data(withJSONObject: self) }
}

