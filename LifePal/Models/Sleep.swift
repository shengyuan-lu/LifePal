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
    
    func getBedTime() -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"

        if let date = dateFormatter.date(from: self.bedTime) {
            
            dateFormatter.dateFormat = "h:mm a"
            
            let formattedString = dateFormatter.string(from: date)

            return formattedString
            
        } else {
            return "API Error - ML Result Not Available"
        }
        
    }
    
    
    func isSameDay() -> Bool {
        
        if day == "before" {
            return false
        } else {
            return true
        }
        
    }
    
    func isBedtimeValid() -> Bool {
        if bedTime.count == 4 && !bedTime.hasPrefix("-") {
            return true
            
        } else {
            
            return false
            
        }

    }
}






