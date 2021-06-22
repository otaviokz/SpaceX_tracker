//
//  FilterOptions.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 15/06/2021.
//

import Foundation

class FilterOptions {
    private var yearsSet: Set<Int> = [] {
        didSet {
            checkedYears = checkedYears.intersection(yearsSet)
        }
    }
    
    var years: [Int] = [] {
        didSet {
            yearsSet = Set(years)
        }
    }
    
    var checkedYears: Set<Int> = []
    var success: Bool = false
    
    var shouldFilterYears: Bool {
        !checkedYears.isEmpty
    }
    
    init(years: [Int] = [], checkedYears: Set<Int> = [], success: Bool = false) {
        self.years = years
        self.checkedYears = checkedYears
    }
    
    func toggleChecked(year: Int) {
        if checkedYears.contains(year) {
            checkedYears.remove(year)
        } else {
            checkedYears.insert(year)
        }
    }
    
    func isChecked(year: Int) -> Bool {
        checkedYears.contains(year)
    }
    
    func toggleSucces() {
        success.toggle()
    }
}
