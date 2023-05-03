//
//  MeView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/2/23.
//

import SwiftUI

struct MeView: View {
    
    @StateObject var healthVM: HealthVM
    
    var body: some View {
        
        VStack {
            ScrollView {
                MeViewDataCell(label: "Height", data: healthVM.height, unit: "CM")
                MeViewDataCell(label: "Weight", data: healthVM.weight, unit: "KG")
                MeViewDataCell(label: "Calorie", data: healthVM.calories, unit: "Calories")
            }
            .padding()
        }
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.large)

    }
}
