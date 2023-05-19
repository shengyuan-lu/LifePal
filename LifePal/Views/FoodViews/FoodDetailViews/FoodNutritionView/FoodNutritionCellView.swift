import SwiftUI

struct FoodNutritionCellView: View {
    
    let nutrtionName: String
    let nutritionValue: String
    
    // nutritionName : unit
    let unitDict: [String : String] = [
        "Calcium" : "mg",
        "Calories" : "kCal",
        "Calories From Fat" : "kCal",
        "Cholesterol" : "mg",
        "Dietary Fiber" : "g",
        "Iron" : "mg",
        "Protein" : "g",
        "Saturated Fat" : "g",
        "Serving Size" : "serving(s)",
        "Sodium" : "mg",
        "Sugars" : "g",
        "Total Carbohydrates" : "g",
        "Total Fat" : "g",
        "Trans Fat" : "g",
        "Vitamin C" : "IU",
        "Vitamin A" : "IU"
    ]
    
    var body: some View {
        
        VStack {
            HStack {
                Text(nutrtionName.camelCaseToWords().capitalized)
                    .bold()
                
                Spacer()
                
                Text(getNutritionValue() + getUnit())
            }
            .font(.footnote)
        }

    }
    
    func getNutritionValue() -> String {
        if nutritionValue.starts(with: "/") {
            return "1" + nutritionValue
        }
        
        return nutritionValue
    }
    
    func getUnit() -> String {
        
        if let unit = unitDict[nutrtionName.camelCaseToWords().capitalized] {
            return " " + unit
        }
        
        return ""
    }
    
    
    
}

struct FoodNutritionCellView_Previews: PreviewProvider {
    static var previews: some View {
        FoodNutritionCellView(nutrtionName: "totalFat", nutritionValue: "8")
            .previewLayout(PreviewLayout.sizeThatFits)
            .previewDisplayName("Default preview")
    }
}
