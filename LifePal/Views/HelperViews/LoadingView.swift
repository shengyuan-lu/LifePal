//
//  LoadingView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/29/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        VStack {
            Spacer()
            
            ProgressView()
                .scaleEffect(2)
                .padding(.bottom, 24)
            
            Text("Loading...")
                .bold()
            
            Spacer()
        }
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
