//
//  APIResponse.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//
import Foundation

enum APIError: Error {
    case invalidData
    case httpError
    case other(Error)
    
    static func map(_ error: Error) -> APIError {
        (error as? APIError) ?? .other(error)
    }
}
