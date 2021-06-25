//
//  ImageLoader.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

import UIKit
import Combine

protocol ImageLoaderType {
    func image(for url: URL, completion: @escaping (DataResponse<(UIImage, URL)>) -> Void)
}

class ImageLoader: ImageLoaderType {
    private var cache = ThreadSafeCache<URL, UIImage>()
    private lazy var downloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
    static let shared = ImageLoader()
    private init() {}
    private var cancellables: [AnyCancellable] = []
    
    func image(for url: URL, completion: @escaping (DataResponse<(UIImage, URL)>) -> Void) {
        if let image = cache[url] {
            completion(.success((image, url)))
        } else {
            downloadQueue.addOperation { [unowned self] in
                APIAssembler.httpClient.getImage(url, cachePolicy: .returnCacheDataElseLoad)
                    .sink {
                        if case .failure(let error) = $0 { completion(.failure(error)) }
                    } receiveValue: {
                        completion(.success(($0, url)))
                        cache[url] = $0
                    }
                    .store(in: &cancellables)
            }
        }
    }
}
