//
//  FoodView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

struct FoodView: View {
    
    @ObservedObject var healthVM: HealthVM
    
    @ObservedObject var menu: MenuModel
    
    var body: some View {
        
        List {
            
            ForEach(menu.categories, id: \.id) { category in
                
                Section(header: Text(category.categoryName)) {
                    
                    ForEach(category.foods, id: \.id) { food in
                        
                        NavigationLink {
                            SingleDetailedFoodCell(food: food)
                        } label: {
                            Text(food.name)
                        }
                        
                    }
                }
                
                
            }
            
            
        }
        
    }
}
