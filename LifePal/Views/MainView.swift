//
//  MainView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            FoodView()
                .tabItem {
                    Label("Food", systemImage: "fork.knife")
                }

            WaterView()
                .tabItem {
                    Label("Water", systemImage: "drop")
                }
            
            SleepView()
                .tabItem {
                    Label("Sleep", systemImage: "bed.double")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
