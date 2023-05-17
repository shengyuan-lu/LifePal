import SwiftUI

struct ExpandButtonView: View {
    
    @Binding var isExpanded:Bool
    
    var body: some View {
        Button {
            isExpanded.toggle()
        } label: {
            HStack(spacing: 4) {
                
                if !isExpanded {
                    Text("Expand")
                    Image(systemName: "chevron.down")
                    
                } else {
                    Text("Retract")
                    Image(systemName: "chevron.up")
                    
                }
            }
        }
    }
}

struct ExpandButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandButtonView(isExpanded: Binding.constant(true))
            .padding()
            .previewLayout(PreviewLayout.sizeThatFits)
            .previewDisplayName("Default preview")
    }
}
