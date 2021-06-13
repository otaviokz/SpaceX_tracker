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
    
    private init() {
        companyData = try! JsonLoader.company()
        launchesData = APIQueryResponse(documents: try! JsonLoader.launches())
    }
    
    init(company: Company?, launches: [Launch]?) {
        self.companyData = company
        if let launches = launches {
            self.launchesData = APIQueryResponse(documents: launches)
        }
    }
    
    func getData(url: URL, cachePolicy: NSURLRequest.CachePolicy, completion: @escaping DataCompletion<Data>) {
        if let data = Style.Image.badgePlaceholder?.pngData() {
            completion(.success(data))
        } else {
            completion(.failure(APIError.invalidHTTPResponse))
        }
    }
    
    func get<T>(url: URL, completion: @escaping APICompletion<T>) where T : Decodable {
        if let company = companyData as? T {
            completion(.success(company))
        } else {
            completion(.failure(APIError.invalidHTTPResponse))
        }
    }
    
    func post<T>(url: URL, body: [String : Any], completion: @escaping APICompletion<T>) where T : Decodable {
        if let response = launchesData as? T {
            completion(.success(response))
        } else {
            completion(.failure(APIError.invalidHTTPResponse))
        }
    }
}
