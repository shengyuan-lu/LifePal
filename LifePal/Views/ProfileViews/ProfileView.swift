//
//  ProfileView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/2/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var healthVM: HealthVM
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        List {
            
            HStack(alignment: .center, spacing: 16) {
                
                Image("peter")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .padding(4)
                    .padding(.trailing, 4)
                
                VStack(alignment: .leading, spacing: 8) {
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
            
            
            Section(header: Text("Basic Information")) {
                ProfileViewDataCell(label: "Age", data: healthVM.age, unit: "")
                ProfileViewDataCell(label: "Biological Sex", data: healthVM.bioSex, unit: "")
            }
            
            
            Section(header: Text("Your Body")) {
                ProfileViewDataCell(label: "Height", data: healthVM.height, unit: "CM")
                ProfileViewDataCell(label: "Weight", data: healthVM.weight, unit: "KG")
                ProfileViewDataCell(label: "Body Fat Percentage", data: healthVM.bodyFatPercentage * 100, unit: "%")
                ProfileViewDataCell(label: "Body Mass Index", data: healthVM.bodyMassIndex, unit: "")
            }
            
            
            Section(header: Text("Activity Level (Today)")) {
                ProfileViewDataCell(label: "Active Energy", data: healthVM.activeCalories, unit: "KCal")
                ProfileViewDataCell(label: "Rest Energy", data: healthVM.restCalories, unit: "KCal")
            }
            
            
            Section(header: Text("Activity Level (Average)")) {
                ProfileViewDataCell(label: "Active Energy (Last 7 Days)", data: healthVM.avgActiveCalories, unit: "KCal")
            }
            
            Section {
                
                Button {
                    self.healthVM.load()
                    
                    self.showAlert.toggle()
                    
                } label: {
                    
                    HStack {
                        Spacer()
                        
                        Text("Sync Data")
                            .bold()
                        
                        Spacer()
                    }
                    .padding(16)
                    .padding(.horizontal, 16)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(.plain)

            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text("Synced Data From Apple HealthKit"), dismissButton: .default(Text("OK")))
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.large)
        
    }
}
