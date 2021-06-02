//
//  Coordinating.swift
//  SpaceX_Tracker
//
//  Created by Otávio Zabaleta on 02/06/2021.
//

import UIKit

protocol Coordinating {
    var navigationController: UINavigationController { get }
    func start()
}
