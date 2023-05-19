//
//  Enums.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/2/23.
//

import Foundation

enum Tabs: String {
    case food
    case water
    case sleep
    case profile
}

enum Menus: String, CaseIterable {
    case recommended = "Recommended"
    case full = "Full Menu"
}
