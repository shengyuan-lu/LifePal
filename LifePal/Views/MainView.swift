//
//  MainView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var recommendedMenuVM: MenuVM = MenuVM(isRecommeded: true)
    @StateObject var fullMenuVM: MenuVM = MenuVM(isRecommeded: false)
    
    @StateObject var healthVM: HealthVM = HealthVM()
    
    @State var selectedTab: Tabs = .foodTab

    var body: some View {
        
        NavigationView {
            
            TabView(selection: $selectedTab) {
                FoodView(healthVM: healthVM, fullMenuVM: fullMenuVM, recommendedMenuVm: recommendedMenuVM)
                    .tabItem {
                        Label("Food", systemImage: "fork.knife")
                    }
                    .tag(Tabs.foodTab)

                WaterView(healthVM: healthVM)
                    .tabItem {
                        Label("Water", systemImage: "drop")
                    }
                    .tag(Tabs.waterTab)
                
                SleepView(healthVM: healthVM)
                    .tabItem {
                        Label("Sleep", systemImage: "bed.double")
                    }
                    .tag(Tabs.sleepTab)
                
                ProfileView(healthVM: healthVM)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(Tabs.profileTab)
            }
            .navigationTitle(selectedTab.rawValue.capitalized)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .onAppear {
                
                healthVM.load()
                
                recommendedMenuVM.load()
                
                fullMenuVM.load()
            }

        }
        .navigationViewStyle(.stack)
    
    }
}
