//
//  ImageLoader.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

import UIKit

protocol ImageLoaderType {
    func image(for url: URL, completion: @escaping (DataResponse<(UIImage, URL)>) -> Void)
}

class ImageLoader: ImageLoaderType {
    private var cache: [URL: UIImage] = [:]
    private lazy var downloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
    
    static let shared = ImageLoader()
    private init() {}
    
    func image(for url: URL, completion: @escaping (DataResponse<(UIImage, URL)>) -> Void) {
        if let image = cache[url] {
            completion(.success((image, url)))
            return
        } else {
            downloadQueue.addOperation { [weak self] in
                HTTPClient.shared.getData(url: url, cachePolicy: .returnCacheDataElseLoad) {
                    if let data = $0.data, let image = UIImage(data: data) {
                        self?.cache[url] = image
                        completion(.success((image, url)))
                    } else {
                        completion(.failure($0.error ?? APIError.notAbleToDecodeData))
                    }
                }
            }
        }
    }
}
