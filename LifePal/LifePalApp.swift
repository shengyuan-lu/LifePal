//
//  LifePalApp.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

@main
struct LifePalApp: App {
    
    @StateObject var healthVM = HealthVM()
    @StateObject var recommendedMenu: MenuModel = MenuModel(isRecommeded: true)
    @StateObject var fullMenu: MenuModel = MenuModel(isRecommeded: false)
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(healthVM)
                .environmentObject(fullMenu)
                .environmentObject(recommendedMenu)
        }
    }
}
