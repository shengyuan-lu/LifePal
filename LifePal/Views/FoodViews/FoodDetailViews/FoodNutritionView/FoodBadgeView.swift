import SwiftUI

struct FoodBadgeView: View {
    
    let food: Food
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Nutrition Badge(s)")
                    .bold()
                
                Spacer()
                
                Text(String(food.getBadgeCount()))
            }
            .padding(.vertical, 2)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 16) {
                    
                    if food.getNutritionTFvalue(key: .isVegan) {
                        Image("Vegan")
                            .resizable()
                            .frame(width: 55, height: 55)
                    }
                    
                    if food.getNutritionTFvalue(key: .isVegetarian) {
                        Image("Vegetarian")
                            .resizable()
                            .frame(width: 55, height: 55)
                    }
                    
                    if food.getNutritionTFvalue(key: .isEatWell) {
                        Image("EatWell")
                            .resizable()
                            .frame(width: 55, height: 55)
                    }
                    
                    if food.getNutritionTFvalue(key: .isPlantForward) {
                        Image("PlantForward")
                            .resizable()
                            .frame(width: 55, height: 55)
                    }
                    
                }
            }
        }
    }
    
}

struct FoodBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        FoodBadgeView(food: getSampleFood())
            .previewLayout(PreviewLayout.sizeThatFits)
            .previewDisplayName("Default preview")
    }
}
