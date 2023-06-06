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
    
    @Published var sleep: Sleep? = nil
    
    @Published var hasAPIcallCompleted = false
    
    @Published var hasHealthKitCompletedLoading = false
    
    var apiUrl = ""
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    override init() {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 0
        
        wakeUpTime = calendar.date(from: dateComponents)!
    }
    
    func load() {
        
        var url = apiUrl.replacingOccurrences(of: "$wake_time$", with: getWakeUpTimeAPIValue())
        
        print("Assembled Sleep Recommendation API URL (With Wakeup time): \(url)")
        
        self.loadRemoteRealData(url: url)
        // self.loadLocalDemoData()
        
    }
    
    func loadLocalDemoData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let d = self.loadLocalJSON(forName: "SleepSample") {
                self.loadSleep(data: d)
            }
        }

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
        
        let decoder = JSONDecoder()
        
        do {
            
            if let d = data {
                
                self.sleep = try decoder.decode([Sleep].self, from: d).first
                
                self.isLoadingFailed = false
                
                self.hasAPIcallCompleted = true
                
                print("Success: converted JSON data to sleep object(s)")
            }
            
        } catch {
            
            self.isLoadingFailed = true
            print("Failed: can't convert JSON data to sleep object(s)")
            
        }
    }
    
    func getWakeUpTimeAPIValue() -> String {
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.hour, .minute], from: wakeUpTime)
        
        var result = ""
        
        guard let hour = components.hour, let minute = components.minute else {
            return result
        }
        
        
        if hour < 10 {
            result += "0"
        }
        
        result += String(hour)
        
        if minute < 10 {
            result += "0"
        }
        
        result += String(minute)
        
        return result
    }
    
    func getTodayOrTomorrowDateString(isForTomorrow: Bool) -> String {
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: isForTomorrow ? 1 : 0, to: Date())!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        let tomorrowDate = dateFormatter.string(from: tomorrow)
        
        return tomorrowDate
    }
    
}
