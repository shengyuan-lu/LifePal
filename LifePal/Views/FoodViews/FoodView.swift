//
//  FoodView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

struct FoodView: View {
    
    @ObservedObject var healthVM: HealthVM
    @ObservedObject var fullMenu: MenuModel
    @ObservedObject var recommendedMenu: MenuModel
    
    @State private var selectedMenu: Menus = .recommended
    
    var body: some View {
        
        VStack {
            
            Picker(selection: $selectedMenu) {
                
                ForEach(Menus.allCases, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
                
            } label: {
                Text("Menu")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            
            if selectedMenu == .full {
                // Full menu here
                
                MenuView(menu: fullMenu)
                
            } else {
                // Display recommended
                
                MenuView(menu: recommendedMenu)
            }

        }
        

    }
    
}
