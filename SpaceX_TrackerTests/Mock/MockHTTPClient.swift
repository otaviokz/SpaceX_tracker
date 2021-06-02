//
//  MockSpaceXAPIClient.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

class MockHTTPClient: HTTPClientType {
    var launchesCompletion: (() -> Void)?
    var launchesData: APIQueryResponse<[Launch]>?
    var companyCompletion: (() -> Void)?
    var companyData: Company?
    
    func get<T>(url: URL, completion: @escaping APICompletion<T>) where T : Decodable {
        companyCompletion = {
            if let company = self.companyData as? T {
                completion(.success(company))
            } else {
                completion(.failure(APIError.notHttpResponse))
            }
        }
    }
    
    func getData(url: URL, cachePolicy: NSURLRequest.CachePolicy, completion: @escaping DataCompletion<Data>) {
        if let data = UIImage(named: "badge_placeholder")?.pngData() {
            completion(.success(data))
        } else {
            completion(.failure(APIError.notHttpResponse))
        }
    }
    
    func post<T>(url: URL, body: [String : Any], completion: @escaping APICompletion<T>) where T : Decodable {
        do {
            launchesCompletion = {
                if let response = self.launchesData as? T {
                    completion(.success(response))
                } else {
                    completion(.failure(APIError.notHttpResponse))
                }
            }
        }
    }
}

