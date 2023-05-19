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
        
        List {
            
            HStack(alignment: .center, spacing: 16) {
                
                Image("peter")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .padding(4)
                    .padding(.trailing, 4)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Welcome 👋")
                        .font(.title3)
                        .lineLimit(1)
                        .bold()
                    
                    Text("Peter Anteater")
                        .font(.title)
                        .lineLimit(1)
                        .bold()
                }
            }
            
            
            Section(header: Text("Your Body")) {
                ProfileViewDataCell(label: "Height", data: healthVM.height, unit: "CM")
                ProfileViewDataCell(label: "Weight", data: healthVM.weight, unit: "KG")
                ProfileViewDataCell(label: "Age", data: healthVM.age, unit: "")
                ProfileViewDataCell(label: "Biological Sex", data: healthVM.bioSex, unit: "")
            }
            
            
            Section(header: Text("Your Activity Level Today")) {
                ProfileViewDataCell(label: "Active Energy", data: healthVM.activeCalories, unit: "KCal")
                ProfileViewDataCell(label: "Rest Energy", data: healthVM.restCalories, unit: "KCal")
            }
            
            
        }
        .onAppear {
            healthVM.loadData()
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.large)
        
    }
}
