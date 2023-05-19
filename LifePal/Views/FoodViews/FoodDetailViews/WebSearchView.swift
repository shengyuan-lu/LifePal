import SwiftUI

struct WebSearchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let url: URL
    
    var body: some View {
        
        NavigationView {
            WebView(url: url)
                .toolbar {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                    
                }
                .edgesIgnoringSafeArea(.all)
                .navigationTitle("Web Search")
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
}
