//
//  Food.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/16/23.
//

import Foundation
import UIKit

struct Food: Decodable, Hashable {
    
    let name: String
    let description: String
    var nutrition: [String : Any?]
    var nutrtionCellList: [String : String] = [:]
    let id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case nutrition
    }
    
    init(name: String, description: String, nutrition: [String : Any?]) {
        self.name = name
        self.description = description
        self.nutrition = nutrition
        getSubDict()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: CodingKeys.name)
        let description = try container.decode(String.self, forKey: CodingKeys.description)
        let nutrition = try container.decode([String : Any].self, forKey: CodingKeys.nutrition)
        
        self.name = name
        self.description = description
        self.nutrition = nutrition
        getSubDict()
    }
    
    static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(description)
    }
    
    enum NutritionTFValueKey : String {
        case isVegan = "isVegan"
        case isVegetarian = "isVegetarian"
        case isEatWell = "isEatWell"
        case isPlantForward = "isPlantForward"
        case isWholeGrains = "isWholeGrains"
    }
    
    enum NutritionStrValueKey : String {
        case servingSize = "servingSize"
        case servingUnit = "servingUnit"
        case totalFat = "totalFat"
        case transFat = "transFat"
        case cholesterol = "cholesterol"
        case sodium = "sodium"
        case totalCarbohydrates = "totalCarbohydrates"
        case dietaryFiber = "dietaryFiber"
        case sugars = "sugars"
        case protein = "protein"
        case vitaminA = "vitaminA"
        case vitaminC = "vitaminC"
        case calcium = "calcium"
        case iron = "iron"
        case saturatedFat = "saturatedFat"
    }
    
    enum NutritionCalorieValueKey : String {
        case calories = "calories"
        case caloriesFromFat = "caloriesFromFat"
    }
    
    func getNutritionTFvalue(key: NutritionTFValueKey) -> Bool {
        
        guard let value = self.nutrition[key.rawValue] else { return false }
        
        return value as! Bool
    }
    
    func getNutritionStrValue(key: NutritionStrValueKey) -> String? {
        guard let value = self.nutrition[key.rawValue] else { return nil }
        
        return value as? String
    }
    
    func getNutritionCalorieValue(key: NutritionCalorieValueKey) -> Int {
        guard let value = self.nutrition[key.rawValue] else { return 0 }

        if value as! String == "" {
            return 0
        }
        
        return Int(value as! String)!
    }
    
    func hasBadge() -> Bool {
        
        if (getNutritionTFvalue(key: .isPlantForward) == true || getNutritionTFvalue(key: .isEatWell) == true || getNutritionTFvalue(key: .isVegetarian) == true || getNutritionTFvalue(key: .isVegan) == true || getNutritionTFvalue(key: .isWholeGrains)) == true {
            
            return true
            
        } else {
            
            return false
            
        }
    }
    
    func getBadgeCount() -> Int {
        var i: Int = 0
        
        if getNutritionTFvalue(key: .isWholeGrains) == true {
            i += 1
        }
        
        if getNutritionTFvalue(key: .isVegan) == true {
            i += 1
        }
        
        if getNutritionTFvalue(key: .isVegetarian) == true {
            i += 1
        }
        
        if getNutritionTFvalue(key: .isEatWell) == true {
            i += 1
        }
        
        if getNutritionTFvalue(key: .isPlantForward) == true {
            i += 1
        }
        
        return i
    }
    
    mutating func getSubDict() -> Void {
        for key in self.nutrition.keys {
            if let value = self.nutrition[key] as? String {
                self.nutrtionCellList[key] = value
            }
        }
        
        // self.nutrition = self.nutrition.filter( { !(($0.value as? String)?.isEmpty ?? false) })
    }
    

}

func getSampleFood() -> Food {
    
    let sampleNutrition: [String : Any?] = [
        "isVegan": true,
        "isVegetarian": true,
        "servingSize": "2",
        "servingUnit": "tablespoons",
        "calories": "60",
        "caloriesFromFat": "45",
        "totalFat": "5",
        "transFat": "0",
        "cholesterol": "0",
        "sodium": "200",
        "totalCarbohydrates": "4",
        "dietaryFiber": "0",
        "sugars": "4",
        "protein": "0",
        "vitaminA": nil,
        "vitaminC": nil,
        "calcium": nil,
        "iron": nil,
        "saturatedFat": "0.5",
        "isEatWell": false,
        "isPlantForward": false,
        "isWholeGrains": false
    ]
    
    return Food(name: "Beijing Roasted Duck", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", nutrition: sampleNutrition)
}
