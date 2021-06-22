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
        ProcessInfo().environment["UITesting"] == "YES"
        #else
        false
        #endif
    }
    
    static func optimiseForTestsIfTesting(window: UIWindow?) {
        guard isRunningTests else { return }
        // Disable animations
        UIView.setAnimationsEnabled(false)
        // Speed up transitions
        window?.layer.speed = 2000
        
        // Disable hardware keyboards.
        let sel = NSSelectorFromString("setHardwareLayout:")
        UITextInputMode.activeInputModes.filter { $0.responds(to: sel) }.forEach { $0.perform(sel, with: nil) }
    }
}
