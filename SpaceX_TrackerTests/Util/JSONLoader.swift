//
//  JSONLoader.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import Foundation

class JsonLoader {
    static func loadJson<T: Decodable>(_ filename: String) throws -> T {
        let data: Data
        
        guard let file = Bundle(for: Self.self).url(forResource: filename, withExtension: "json") else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        data = try Data(contentsOf: file)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
