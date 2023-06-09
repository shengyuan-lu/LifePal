//
//  MainView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var healthVM = HealthVM()
    
    @StateObject var recommendedMenuVM: MenuVM = MenuVM(isRecommeded: true)
    @StateObject var fullMenuVM: MenuVM = MenuVM(isRecommeded: false)
    
    @StateObject var waterVM: WaterVM = WaterVM()
    @StateObject var sleepVM: SleepVM = SleepVM()
    
    @State var selectedTab: Tabs = .profileTab
    
    var body: some View {
        
        NavigationView {
            
            TabView(selection: $selectedTab) {
                
                ProfileView(healthVM: healthVM)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(Tabs.profileTab)
                
                FoodView(healthVM: healthVM, fullMenuVM: fullMenuVM, recommendedMenuVm: recommendedMenuVM)
                    .tabItem {
                        Label("Food", systemImage: "fork.knife")
                    }
                    .tag(Tabs.foodTab)
                
                WaterView(healthVM: healthVM, waterVM: waterVM)
                    .tabItem {
                        Label("Water", systemImage: "drop")
                    }
                    .tag(Tabs.waterTab)
                
                SleepView(healthVM: healthVM, sleepVM: sleepVM)
                    .tabItem {
                        Label("Sleep", systemImage: "bed.double")
                    }
                    .tag(Tabs.sleepTab)
            }
            .navigationTitle(selectedTab.rawValue.capitalized)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .onChange(of: healthVM.isLoadingComplete) { complete in
                
                if complete {
                    
                    let foodApiUrl = healthVM.assembleMenuRecommendationAPIString()
                    let waterApiUrl = healthVM.assembleWaterRecommendationAPIString()
                    let sleepApiUrl = healthVM.assembleSleepRecommendationAPIString()
                    
                    recommendedMenuVM.load(url: foodApiUrl)
                    
                    fullMenuVM.load(url: foodApiUrl)
                    
                    waterVM.load(url: waterApiUrl)
                    
                    sleepVM.hasHealthKitCompletedLoading = true
                    sleepVM.apiUrl = sleepApiUrl
                }
                
            }
            
        }
        .navigationViewStyle(.stack)
        
    }
}
