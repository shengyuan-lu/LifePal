//
//  Enums.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/2/23.
//

import Foundation

enum Tabs: String {
    case foodTab = "Food"
    case waterTab = "Water"
    case sleepTab = "Sleep"
    case profileTab = "Profile"
}

enum Menus: String, CaseIterable {
    case recommended = "Recommended"
    case full = "Full Menu"
}

enum WaterSize: Double {
    case mouthful = 0.125
    case cup = 0.250
    case bottle = 0.500
}
