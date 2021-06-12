//
//  JSONLoader+App.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 30/05/2021.
//

import Foundation

extension JsonLoader {
    static func company() throws -> Company { try loadJson("TestCompanyInfo_v4") }
    static func launches() throws -> [Launch] { try loadJson("SampleLaunches_PopulatedRockets_v4") }
}
