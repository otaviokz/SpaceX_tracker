//
//  DataResponse.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

import Foundation

struct DataResponse<T> {
    let data: T?
    let error: Error?
}

extension DataResponse {
    static func error(_ error: Error) -> DataResponse {
        DataResponse(data: nil, error: error)
    }
    
    static func success(_ data: T?) -> DataResponse {
        DataResponse(data: data, error: nil)
    }
}
