//
//  Category.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/16/23.
//

import Foundation

struct Category: Decodable, Hashable {
    
    let categoryName: String
    let id = UUID()
    var foods: [Food]
    
    enum CodingKeys: String, CodingKey {
        case categoryName = "category"
        case foods = "items"
    }
    
    init(category: String, items: [Food]) {
        self.categoryName = category
        self.foods = items
    }
}

func getSampleCategory() -> Category {
    
    var foodArray = [Food]()
    
    for _ in 0...3 {
        foodArray.append(getSampleFood())
    }
    
    return Category(category: "Condiments", items: foodArray)
}


