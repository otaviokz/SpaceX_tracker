//
//  DataResult.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

struct DataResult<T> {
    let data: T?
    let error: APIError?
}

extension DataResult {
    static func failure(_ error: APIError) -> DataResult {
        DataResult(data: nil, error: error)
    }
    
    static func success(_ data: T?) -> DataResult {
        DataResult(data: data, error: nil)
    }
}
