//
//  FoodView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

struct FoodView: View {
    
    @ObservedObject var healthVM: HealthVM
    @ObservedObject var fullMenu: MenuVM
    @ObservedObject var recommendedMenu: MenuVM
    
    @State private var selectedMenu: Menus = .recommended
    
    var body: some View {
        
        VStack {
            
            Picker(selection: $selectedMenu) {
                
                ForEach(Menus.allCases, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
                
            } label: {
                Text("Menu Selection")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            
            
            
            if selectedMenu == .full {
                
                MenuView(menu: fullMenu)
                
            } else {

                MenuView(menu: recommendedMenu)
            }

        }
        

    }
    
}
