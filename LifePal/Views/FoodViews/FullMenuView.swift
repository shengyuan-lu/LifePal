//
//  FullMenuView.swift
//  LifePal
//
//  Created by Arkin Jai Singh Verma on 5/18/23.
//

import SwiftUI

struct FullMenuView: View {
    let menu: MenuModel
    
    var body: some View {
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

struct FullMenuView_Previews: PreviewProvider {
    static var menu = MenuModel()
    
    static var previews: some View {
        FullMenuView(menu: menu)
    }
}
