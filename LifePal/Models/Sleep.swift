//
//  Sleep.swift
//  LifePal
//
//  Created by Shengyuan Lu on 6/4/23.
//

import Foundation


struct Sleep: Decodable, Hashable {
    
    private let bedTime: String
    private let day: String
    
    let id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case bedTime = "sleep_time"
        case day = "date"
    }
    
    
    // Conversion functions
    
    func getBedTime(_ bedtime: String) -> Date? {
        
        // Convert bedTime to a Date to be displayed in UI
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a" // Specify the format of the bedtime string
        
        return formatter.date(from: bedtime)
    }
    
    
    func isSameDay() -> Bool {
        
        if day == "same" {
            return true
        } else {
            return false
        }
        
    }
    
    
}

