//
//  FilterOptions.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 15/06/2021.
//

import Foundation

class FilterOptions {
    var years: [Int] = [] {
        didSet {
            checkedYears = Set(checkedYears).intersection(Set(years)).sorted()
        }
    }
    
    var checkedYears: [Int] = []
    var success: Bool = false
    
    init(availableYears: [Int] = [], checkedYears: [Int] = [], success: Bool = false) {
        self.years = availableYears
    }
    
    func toggleChecked(year: Int) {
        if checkedYears.contains(year) {
            checkedYears = checkedYears.filter { $0 != year }
        } else {
            checkedYears.append(year)
        }
    }
    
    func isChecked(year: Int) -> Bool {
        checkedYears.contains(year)
    }
    
    func toggleSucces() {
        success.toggle()
    }
}
