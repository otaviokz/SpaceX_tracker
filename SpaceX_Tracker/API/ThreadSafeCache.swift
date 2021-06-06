//
//  ThreadSafeCache.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 06/06/2021.
//

import Foundation

class ThreadSafeCache<Key: Hashable, Value> {
    private var dictionary = [Key: Value]()
    private lazy var queue = DispatchQueue(label: String(describing: dictionary), qos: .userInteractive, attributes: .concurrent)
    
    subscript(key: Key) -> Value? {
        get {
            queue.sync { dictionary[key] }
        }
        set {
            queue.async(flags: .barrier) {
                self.dictionary[key] = newValue
            }
        }
    }
}

