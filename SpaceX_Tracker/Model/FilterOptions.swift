//
//  FilterOptions.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 15/06/2021.
//

import Foundation

class FilterOptions {
    @Published private(set) var isFiltering: Bool = false
    
    var years: [Int] = [] {
        didSet { checkedYears = checkedYears.intersection(Set(years)) }
    }
    
    private(set) var checkedYears: Set<Int> = [] { didSet { updateIsFiltering() } }
    private(set) var success: Bool = false { didSet { updateIsFiltering() } }
    
    var shouldFilterYears: Bool {
        !checkedYears.isEmpty
    }
    
    init(years: [Int] = [], checkedYears: Set<Int> = [], success: Bool = false) {
        self.years = years
        self.checkedYears = checkedYears
    }
    
    private func updateIsFiltering() {
        isFiltering = shouldFilterYears || success
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
    
    func update(for launches: [Launch]) {
        years = launches.availableYears
    }
    
    func filter(_ launches: [Launch], sortAscending: Bool = false) -> [Launch] {
        var filtered = launches
        
        if success {
            filtered = filtered.filter { $0.success == true }
        }
        
        if shouldFilterYears {
            filtered = filtered.filter { isChecked(year: $0.launchYear) }
        }
        
        if sortAscending {
            filtered.sort()
        }
        
        return filtered
    }
}

private extension Array where Element == Launch {
    var availableYears: [Int] {
        Set(map { $0.launchYear }).sorted()
    }
}
