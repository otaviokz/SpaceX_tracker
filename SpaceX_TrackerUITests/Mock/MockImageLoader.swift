//
//  MockImageLoader.swift
//  SpaceX_TrackerUITests
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

import UIKit

class MockImageLoader: ImageLoaderType {
    static let shared = MockImageLoader()
    
    private init() {}
    
    func image(for url: URL, completion: @escaping (DataResponse<(UIImage, URL)>) -> Void) {
        completion(.success((UIImage(named: "badge_placeholder")!, url)))
    }
}
