//
//  JSONLoader.swift
//  SpaceX_TrackerTests
//
//  Created by Otávio Zabaleta on 24/05/2021.
//

import Foundation

class JsonLoader {
    static func loadJson<T: Decodable>(_ filename: String) throws -> T {
        guard let file = Bundle(for: Self.self).url(forResource: filename, withExtension: "json") else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        return try JSONDecoder().decode(T.self, from: try Data(contentsOf: file))
    }
}
