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
    
    @State private var selection = "Recommendations"
    let options = ["Recommendations", "Full Menu"]
    
    var body: some View {
        VStack {
            Picker("Select Food Display", selection: $selection) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            
            
            List {
                
                ForEach(menu.categories, id: \.id) { category in
                    
                    Section(header: Text(category.categoryName)) {
                        
                        ForEach(category.foods, id: \.id) { food in
                            
                            NavigationLink {
                                SingleDetailedFoodCell(food: food)
                            } label: {
                                Text(food.name)
                                    .foregroundColor(.primary) // TODO: Make color darker
                                    
                            }
                            
                        }
                    }
                    
                    
                }
                
                
            }
        }
        
        
        
    }
}

// Preview for view
struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView(healthVM: HealthVM(), menu: MenuModel())
            
    }
}
