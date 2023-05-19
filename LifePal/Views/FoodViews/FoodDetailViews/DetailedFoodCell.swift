import SwiftUI

struct DetailedFoodCell: View {
    
    @State var food: Food
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            HStack {
                VStack(spacing: 4) {
                    
                    HStack {
                        Text(food.name)
                            .bold()
                            .font(.title2)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(String(food.getNutritionCalorieValue(key: .calories)) + " Calories")
                        
                        Spacer()
                    }
                }
                
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 4) {
                
                HStack {
                    Text("Description")
                        .bold()
                    
                    Spacer()
                }
                
                
                Text(self.getFoodDescription())
                    .font(.callout)
                    .fixedSize(horizontal: false, vertical: true)
                
                
            }
            
            
            if hasNutritionInfo() {
                
                Divider()
                
                HStack {
                    Text("Nutrition Info")
                        .bold()
                    
                    Spacer()
                    
                }
            }
                
            FoodNutritionView(food: food)
            
            
            if food.hasBadge() {
                
                Divider()
                
                FoodBadgeView(food: food)
            }
            
            Divider()
        }
    }
    
    func hasNutritionInfo() -> Bool {
        
        for nutrition in AllNutritionKeys.allCases {
            if let _ = food.nutrition[nutrition.rawValue] {
                return true
            }
        }
        
        return false
    }
    
    
    func getFoodDescription() -> String {
        if food.description == "" || food.description == "N/A" {
            return "Not Available"
        } else {
            return food.description
        }
    }
    
    
    func processName(name: String) -> String {
        var str = ""
        let postStr = removeSpecialCharsFromString(text: name)
        let strArray = postStr.split(separator: " ")
        
        for item in strArray {
            str.append(contentsOf: item)
            str.append("+")
        }
        
        let string = str.dropLast()
        
        return String(string)
    }
    
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return text.filter { okayChars.contains($0) }
    }
    
    enum AllNutritionKeys : String, CaseIterable {
        case isVegan = "isVegan"
        case isVegetarian = "isVegetarian"
        case isEatWell = "isEatWell"
        case isPlantForward = "isPlantForward"
        case isWholeGrains = "isWholeGrains"
        
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
        case calories = "calories"
        case caloriesFromFat = "caloriesFromFat"
    }
}

struct DetailedFoodCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailedFoodCell(food: getSampleFood())
            .previewLayout(PreviewLayout.sizeThatFits)
            .previewDisplayName("Default preview")
    }
}
