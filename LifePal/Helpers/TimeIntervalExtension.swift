//
//  TimeIntervalExtension.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/30/23.
//

import Foundation

extension TimeInterval {
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d H %0.2d M", hours, minutes)
        
    }
}
