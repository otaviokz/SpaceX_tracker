//
//  RuntimeService.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 31/05/2021.
//

import UIKit

struct RuntimeService {
    static var isRunningTests: Bool {
        #if DEBUG
        return ProcessInfo().environment["UITesting"] == "YES"
        #else
        return false
        #endif
    }
    
    static func optimiseForTestsIfTesting(window: UIWindow?) {
        #if targetEnvironment(simulator)
        guard isRunningTests else { return }
        // Disable animations
        UIView.setAnimationsEnabled(false)
        // Speed up transitions
        window?.layer.speed = 2000
        
        // Disable hardware keyboards.
        let selector = NSSelectorFromString("setHardwareLayout:")
        UITextInputMode.activeInputModes
            .filter { $0.responds(to: selector) }
            .forEach { $0.perform(selector, with: nil) }
        #endif
    }
    
    static var imageLoader: ImageLoaderType {
        isRunningTests ? MockImageLoader.shared : ImageLoader.shared
    }
    
    static var httpClient: HTTPClientType {
        isRunningTests ? MockHTTPClient() : HTTPClient.shared
    }
}
