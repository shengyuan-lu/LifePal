//
//  MenuView.swift
//  LifePal
//
//  Created by Arkin Jai Singh Verma on 5/18/23.
//

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var menuVM: MenuVM
    
    var body: some View {
        
        if !menuVM.categories.isEmpty {
            
            List {
                
                ForEach(menuVM.categories, id: \.id) { category in
                    
                    Section(header: Text(category.categoryName)) {
                        
                        ForEach(category.foods, id: \.id) { food in
                            
                            NavigationLink {
                                
                                SingleDetailedFoodCell(food: food)
                                
                            } label: {
                                
                                MenuFoodCellView(food: food)
                            }
                            
                        }
                    }
                }
                
            }
            
        } else {
            
            LoadingView()
            
        }
        
    }
}
