//
//  MockSpaceXAPIClient.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

class MockHTTPClient: HTTPClientType {
    static var shared = MockHTTPClient()
    var companyCompletion: (() -> Void)?
    var companyData: Company?
    var launchesData: APIQueryResponse<[Launch]>?
    var launchesCompletion: (() -> Void)?
    
    private init() {}
    
    func refresh() {
        companyData = nil
        companyCompletion = nil
        launchesData = nil
        launchesCompletion = nil
    }
    
    func get<T>(url: URL, completion: @escaping APICompletion<T>) where T : Decodable {
        companyCompletion = {
            if let company = self.companyData as? T {
                completion(.success(company))
            } else {
                completion(.failure(APIError.invalidHTTPResponse))
            }
        }
    }
    
    func getData(url: URL, cachePolicy: NSURLRequest.CachePolicy, completion: @escaping DataCompletion<Data>) {
        if let data = UIImage(named: "badge_placeholder")?.pngData() {
            completion(.success(data))
        } else {
            completion(.failure(APIError.invalidHTTPResponse))
        }
    }
    
    func post<T>(url: URL, body: [String : Any], completion: @escaping APICompletion<T>) where T : Decodable {
        do {
            launchesCompletion = { [unowned self] in
                if let response = self.launchesData as? T {
                    completion(.success(response))
                } else {
                    completion(.failure(APIError.invalidHTTPResponse))
                }
            }
        }
    }
}
