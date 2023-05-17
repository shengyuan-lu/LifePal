//
//  ProfileViewDataCell.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/2/23.
//

import SwiftUI

struct ProfileViewDataCell: View {
    
    let label: String
    let data: Double
    let unit: String
    
    var body: some View {
        
        HStack {
            Text(label)
                .bold()
            
            Spacer()
            
            Text("\(String(format: "%.2f", data)) \(unit)")
        }
        
    }
}
