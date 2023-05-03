//
//  MainView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var healthVM = HealthVM()

    var body: some View {
        
        TabView {
            FoodView(healthVM: healthVM)
                .tabItem {
                    Label("Food", systemImage: "fork.knife")
                }

            WaterView(healthVM: healthVM)
                .tabItem {
                    Label("Water", systemImage: "drop")
                }
            
            SleepView(healthVM: healthVM)
                .tabItem {
                    Label("Sleep", systemImage: "bed.double")
                }
            
            MeView(healthVM: healthVM)
                .tabItem {
                    Label("Me", systemImage: "person.fill")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
