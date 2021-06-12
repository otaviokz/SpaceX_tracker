//
//  MockSpaceXAPIClient.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

class MockHTTPClient: HTTPClientType {
    static var shared = MockHTTPClient()
    var companyData: Company?
    var launchesData: APIQueryResponse<[Launch]>?
    
    private init() {}
    
    func refresh() {
        companyData = nil
        launchesData = nil
    }
    
    func getData(url: URL, cachePolicy: NSURLRequest.CachePolicy, completion: @escaping DataCompletion<Data>) {
        complete {
            if let data = Style.Image.badgePlaceholder?.pngData() {
                completion(.success(data))
            } else {
                completion(.failure(APIError.invalidHTTPResponse))
            }
        }
    }
    
    func get<T>(url: URL, completion: @escaping APICompletion<T>) where T : Decodable {
        complete { [weak self] in
            if let company = self?.companyData as? T {
                completion(.success(company))
            } else {
                completion(.failure(APIError.invalidHTTPResponse))
            }
        }
    }
    
    func post<T>(url: URL, body: [String : Any], completion: @escaping APICompletion<T>) where T : Decodable {
        complete { [weak self] in
            if let response = self?.launchesData as? T {
                completion(.success(response))
            } else {
                completion(.failure(APIError.invalidHTTPResponse))
            }
        }
    }
    
    private func complete(after: TimeInterval = 0.1, block: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: block)
    }
}
