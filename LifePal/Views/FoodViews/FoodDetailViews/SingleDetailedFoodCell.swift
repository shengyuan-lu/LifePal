import SwiftUI

struct SingleDetailedFoodCell: View {
    
    @State var food: Food
    
    var body: some View {

        ScrollView {
            DetailedFoodCell(food: food, isExpanded: false)
                .padding(24)
        }
        .background(Color(UIColor(named: "categoryBG")!))
        .edgesIgnoringSafeArea([.horizontal, .bottom])
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct SingleDetailedFoodCell_Previews: PreviewProvider {
    static var previews: some View {
        SingleDetailedFoodCell(food: getSampleFood())
    }
}
