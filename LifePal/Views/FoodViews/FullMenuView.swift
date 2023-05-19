//
//  FullMenuView.swift
//  LifePal
//
//  Created by Arkin Jai Singh Verma on 5/18/23.
//

import SwiftUI

struct FullMenuView: View {
    
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
