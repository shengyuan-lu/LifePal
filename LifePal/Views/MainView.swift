//
//  MainView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var menuModel: MenuModel
    @EnvironmentObject var healthVM: HealthVM
    
    @State var selectedTab: Tabs = .profile

    var body: some View {
        
        NavigationView {
            
            TabView(selection: $selectedTab) {
                FoodView(healthVM: healthVM, menu: menuModel)
                    .tabItem {
                        Label("Food", systemImage: "fork.knife")
                    }
                    .tag(Tabs.food)

                WaterView(healthVM: healthVM)
                    .tabItem {
                        Label("Water", systemImage: "drop")
                    }
                    .tag(Tabs.water)
                
                SleepView(healthVM: healthVM)
                    .tabItem {
                        Label("Sleep", systemImage: "bed.double")
                    }
                    .tag(Tabs.sleep)
                
                ProfileView(healthVM: healthVM)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(Tabs.profile)
            }
            .navigationTitle(selectedTab.rawValue.capitalized)
        }
    
    }
}
