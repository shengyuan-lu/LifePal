//
//  ProfileViewDataCell.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/2/23.
//

import SwiftUI

struct ProfileViewDataCell: View {
    
    let label: String
    let data: Any
    let unit: String
    
    var body: some View {
        
        HStack {
            Text(label)
                .bold()
            
            Spacer()
            
            switch data {
            case is Double:
                if data as! Double == -1.0 {
                    
                    Text("Loading...")
                    
                } else if data as! Double == -2.0 {
                    
                    Text("Unavailable")
                    
                } else {
                    
                    Text("\(String(format: "%.1f", data as! Double)) \(unit)")
                }
                
            case is String:
                Text(data as! String)
            default:
                Text("Unknown Type")
            }
            
            

        }
        
    }
}
