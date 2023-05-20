import SwiftUI

struct GenericButtonWithLabelView: View {
    
    let action: (() -> Void)
    let buttonText: String
    let systemName: String
    let bgColor: Color
    let textColor: Color
    let edgeInsets: EdgeInsets
    
    var body: some View {
        
        Button {
            action()
            
        } label: {
            
            HStack {
                if systemName != "" {
                    Image(systemName: systemName)
                }
                
                Text(buttonText)
                    .font(.body)
                
            }
            .foregroundColor(textColor)
            .padding(edgeInsets)
            .background(bgColor)
            .cornerRadius(8)
        }
        
        
    }
}

struct GenericButtonWithLabelView_Previews: PreviewProvider {
    static var previews: some View {
        GenericButtonWithLabelView(action: {
            // DO NOTHING FOR PREVIEW
        }, buttonText: String("View All"), systemName: "", bgColor: Color.blue, textColor: Color.black, edgeInsets: EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .padding()
        .previewLayout(PreviewLayout.sizeThatFits)
        .previewDisplayName("Default preview")
    }
}
