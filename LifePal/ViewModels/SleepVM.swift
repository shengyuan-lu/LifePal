//
//  SleepVM.swift
//  LifePal
//
//  Created by Arkin Jai Singh Verma on 6/4/23.
//
import Foundation
import SwiftUI

class SleepVM: JsonLoader {
    
    @Published var wakeUpTime = Date()
    @Published var recommendedBedTime = ""
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    var bedtimeCalculator: BedtimeCalculator {
        BedtimeCalculator()
    }
    
    override init() {}
    
    func load(url: String) {
        self.loadRemoteRealData(url: url)
    }
    
    func loadRemoteRealData(url: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            self.loadRemoteJSON(forURL: url) { data in
                if let d = data {
                    self.loadSleep(data: d)
                }
            }
        }
    }
    
    func loadSleep(data: Data?) -> Void {
        // FIXME: backend
    }
    
    func calculateBedtime() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        recommendedBedTime = bedtimeCalculator.calculateBedtime(for: wakeUpTime, formatter: dateFormatter)
    }
    
    struct BedtimeCalculator {
        var calendar = Calendar.current
        
        func calculateBedtime(for wakeUpTime: Date, formatter: DateFormatter) -> String {
            let components = calendar.dateComponents([.hour, .minute], from: wakeUpTime)
            guard let hour = components.hour, let minute = components.minute else {
                return ""
            }
            
            let totalMinutes = hour * 60 + minute
            let recommendedMinutes = totalMinutes - 8 * 60 // Assuming 8 hours of sleep
            
            let recommendedHour = recommendedMinutes / 60
            let recommendedMinute = recommendedMinutes % 60
            
            let recommendedTime = calendar.date(bySettingHour: recommendedHour, minute: recommendedMinute, second: 0, of: Date()) ?? Date()
            
            return formatter.string(from: recommendedTime)
        }
        
    }
}
