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
                
                if data as! Double == -1.0 || data as! Double == -100 {
                    
                    ProgressView()
                    
                } else if data as! Double == -2.0 {
                    
                    Text("Unavailable")
                    
                } else {
                    
                    if unit == "" && data as! Double > 100 {
                        
                        Text((data as! TimeInterval).stringFromTimeInterval())
                        
                    } else {
                        
                        Text("\(String(format: "%.1f", data as! Double)) \(unit)")
                    }

                }
                
                
            case is Int:
                
                if data as! Int == -1 {
                    
                    ProgressView()
                    
                } else if data as! Int == -2 {
                    
                    Text("Unavailable")
                    
                } else {
                    
                    Text("\(data as! Int) \(unit)")
                }
                
                
            case is String:
                
                if data as! String == "Loading" {
                    
                    ProgressView()
                    
                } else {
                    
                    Text(data as! String)
                }
                
                
            default:
                Text("Unknown Type")
                
                
            }
            
        }
        
    }
}
