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
    @StateObject var recommendedMenu: MenuVM = MenuVM(isRecommeded: true)
    @StateObject var fullMenu: MenuVM = MenuVM(isRecommeded: false)
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear {
                    // correct the transparency bug for Tab bars
                    let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.configureWithOpaqueBackground()
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                    
                    // correct the transparency bug for Navigation bars
                    let navigationBarAppearance = UINavigationBarAppearance()
                    navigationBarAppearance.configureWithOpaqueBackground()
                    UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                }
        }
    }
}
