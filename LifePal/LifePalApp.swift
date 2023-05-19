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
    @StateObject var recommendedMenu: MenuModel = MenuModel(isRecommended: true)
    @StateObject var fullMenu: MenuModel = MenuModel(isRecommended: false)
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(healthVM)
                .environmentObject(fullMenu)
                .environmentObject(recommendedMenu)
        }
    }
}
