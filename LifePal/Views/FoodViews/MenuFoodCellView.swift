//
//  MenuFoodCellView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/18/23.
//

import SwiftUI

struct MenuFoodCellView: View {
    
    let food: Food
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(food.name)
                .bold()
                
            Text("\(food.getNutritionCalorieValue(key: .calories)) Calories")
        }
    }
}
