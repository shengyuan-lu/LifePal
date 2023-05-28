//
//  FoodView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

struct FoodView: View {
    
    @ObservedObject var healthVM: HealthVM
    
    @ObservedObject var fullMenuVM: MenuVM
    @ObservedObject var recommendedMenuVm: MenuVM
    
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
            .padding(.top, 8)
            
            if selectedMenu == .full {
                
                MenuView(menuVM: fullMenuVM)
                
            } else {
                
                MenuView(menuVM: recommendedMenuVm)
            }
            
        }
        
        
    }
    
}
