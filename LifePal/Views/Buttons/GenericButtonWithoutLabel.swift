import SwiftUI

struct GenericButtonWithoutLabel: View {
    
    let action: (() -> Void)
    let systemName: String
    let imageColor: Color
    
    var body: some View {
        
        Button {
            action()
            
        } label: {
            Image(systemName: systemName)
                .foregroundColor(imageColor)
                .font(.largeTitle)
        }
        
    }
}

struct GenericButtonWithoutLabel_Previews: PreviewProvider {
    static var previews: some View {
        GenericButtonWithoutLabel(action: {
            // DO NOTHING FOR PREVIEW
        }, systemName: "magnifyingglass.circle.fill", imageColor: Color.blue)
        .previewLayout(PreviewLayout.sizeThatFits)
        .previewDisplayName("Default preview")
    }
}
