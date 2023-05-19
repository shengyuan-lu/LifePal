//
//  ProfileView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/2/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var healthVM: HealthVM
    
    var body: some View {
        
        VStack {
            ScrollView {
                ProfileViewDataCell(label: "Height", data: healthVM.height, unit: "CM")
                ProfileViewDataCell(label: "Weight", data: healthVM.weight, unit: "KG")
                ProfileViewDataCell(label: "Age", data: Double(healthVM.age), unit: "Year")
                ProfileViewDataCell(label: "Active Energy", data: healthVM.activeCalories, unit: "KCal")
                ProfileViewDataCell(label: "Rest Energy", data: healthVM.restCalories, unit: "KCal")
            }
            .padding()
        }
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.large)

    }
}
