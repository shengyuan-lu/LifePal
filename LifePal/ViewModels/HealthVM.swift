//
//  HealthVM.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/2/23.
//

import Foundation
import SwiftUI
import HealthKit

class HealthVM: ObservableObject {
    
    let healthStoreManager = HealthStoreManager()
    
    @Published var height: Double = -1
    @Published var age: Int = -1
    @Published var weight: Double = -1
    
    @Published var activeCalories: Double = -1
    @Published var restCalories: Double = -1
    @Published var avgActiveCalories: Double = -1
    
    @Published var bodyFatPercentage: Double = -1
    @Published var bodyMassIndex: Double = -1
    
    @Published var avgTimeInBed: TimeInterval = -1
    @Published var avgTimeAsleep: TimeInterval = -1
    
    @Published var bioSex: String = "Loading..."
    
    private var loadedInfoCount: Int = 0
    @Published var isLoadingComplete: Bool = false
    
    private var birthDateComponents: DateComponents = DateComponents()
    private var bioSexObject: HKBiologicalSexObject = HKBiologicalSexObject()
    
    init() {
        
        healthStoreManager.requestAuthorization(completion: { success in
            if success {
                self.load()
            }
        })
    }
    
    func load() {
        
        self.loadedInfoCount = 0
        
        getHeight()
        getWeight()
        
        getActiveCalories()
        getRestCalories()
        getAvgActiveCalories()
        
        getBirthDate()
        getBioSex()
        getBodyFat()
        getBodyMassIndex()
        
        getSleepData()
    }
    
    func loadOneMoreInfo() {
        self.loadedInfoCount += 1
        
        if self.loadedInfoCount == 10 {
            self.isLoadingComplete = true
        }
        
        if self.loadedInfoCount < 10 && self.isLoadingComplete == true {
            self.isLoadingComplete = false
        }
    }
    
    func assembleMenuRecommendationAPIString() -> String {
        
        var apiString = Links.menuRecommendationAPI
        
        apiString = apiString.replacingOccurrences(of: "$user$", with: Constants.user)
        apiString = apiString.replacingOccurrences(of: "$weight$", with: String(Int(weight)))
        apiString = apiString.replacingOccurrences(of: "$bodyfat$", with: String(bodyFatPercentage))
        apiString = apiString.replacingOccurrences(of: "$avg_activity$", with: String(Int(avgActiveCalories)))
        
        print("Assembled Menu Recommendation API URL: \(apiString)")
        
        return apiString
    }
    
    func assembleWaterRecommendationAPIString() -> String {
        
        var apiString = Links.waterRecommendationAPI
        
        apiString = apiString.replacingOccurrences(of: "$user$", with: Constants.user)
        apiString = apiString.replacingOccurrences(of: "$age$", with: String(age))
        apiString = apiString.replacingOccurrences(of: "$weight$", with: String(Int(weight)))
        apiString = apiString.replacingOccurrences(of: "$height$", with: String(Int(height)))
        apiString = apiString.replacingOccurrences(of: "$avg_activity$", with: String(Int(avgActiveCalories)))
        
        print("Assembled Water Recommendation API URL: \(apiString)")
        
        return apiString
    }
    
    
    func assembleSleepRecommendationAPIString(wakeTime: String) -> String {
        
        var apiString = Links.sleepRecommendationAPI
        
        apiString = apiString.replacingOccurrences(of: "$user$", with: Constants.user)
        apiString = apiString.replacingOccurrences(of: "$avg_asleep$", with: String(Int(avgTimeAsleep)))
        apiString = apiString.replacingOccurrences(of: "$avg_inbed$", with: String(Int(avgTimeInBed)))
        apiString = apiString.replacingOccurrences(of: "$avg_activity$", with: String(Int(avgActiveCalories)))
        apiString = apiString.replacingOccurrences(of: "$wake_time$", with: wakeTime)
        
        print("Assembled Sleep Recommendation API URL: \(apiString)")
        
        return apiString
        
    }
    
    
    func getHeight() -> Void {
        
        healthStoreManager.getHeight { result, error in
            
            DispatchQueue.main.async {
                if let r = result {
                    self.height = r
                    
                    self.loadOneMoreInfo()
                    
                } else {
                    self.height = -2
                }
            }
            
        }
    }
    
    
    func getWeight() -> Void {
        
        healthStoreManager.getWeight { result, error in
            
            DispatchQueue.main.async {
                if let r = result {
                    self.weight = r
                    
                    self.loadOneMoreInfo()
                    
                } else {
                    self.weight = -2
                }
            }
            
        }
    }
    
    
    func getActiveCalories() -> Void {
        
        healthStoreManager.getActiveCalories { result, error in
            
            DispatchQueue.main.async {
                
                if let r = result {
                    self.activeCalories = r
                    
                    self.loadOneMoreInfo()
                    
                } else {
                    self.activeCalories = -2
                }
            }
            
        }
    }
    
    
    func getRestCalories() -> Void {
        
        healthStoreManager.getRestCalories { result, error in
            
            DispatchQueue.main.async {
                if let r = result {
                    self.restCalories = r
                } else {
                    self.restCalories = -2
                }
                
                self.loadOneMoreInfo()
            }
        }
    }
    
    func getAvgActiveCalories() -> Void {
        
        healthStoreManager.getAvgActiveCalories { result, error in
            
            DispatchQueue.main.async {
                if let r = result {
                    self.avgActiveCalories = r
                } else {
                    self.avgActiveCalories = -2
                }
                
                self.loadOneMoreInfo()
            }
        }
        
    }
    
    func getAge() -> Void {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: self.birthDateComponents.date!, to: Date())
        self.age = ageComponents.year ?? -2
    }
    
    
    func getBirthDate() -> Void {
        
        healthStoreManager.getBirthDate { dateComponent in
            DispatchQueue.main.async {
                if let dc = dateComponent {
                    self.birthDateComponents = dc
                    self.getAge()
                }
                
                self.loadOneMoreInfo()
            }
        }
        
    }
    
    
    func getBioSexString() -> Void {
        
        switch self.bioSexObject.biologicalSex {
            case .female:
                self.bioSex = "Female"
            case .male:
                self.bioSex = "Male"
            case .other:
                self.bioSex = "Other"
            case .notSet:
                self.bioSex = "Not Set"
            @unknown default:
                self.bioSex = "Unknown"
        }
        
    }
    
    
    func getBioSex() -> Void {
        healthStoreManager.getBiologicalSex(completion: { bioSexObject in
            DispatchQueue.main.async {
                if let bso = bioSexObject {
                    self.bioSexObject = bso
                    self.getBioSexString()
                }
                
                self.loadOneMoreInfo()
            }
        })
    }
    
    
    func getBodyFat() -> Void {
        healthStoreManager.getBodyfat(completion: { result, error in
            DispatchQueue.main.async {
                if let r = result {
                    self.bodyFatPercentage = r
                } else {
                    self.bodyFatPercentage = -2
                }
                
                self.loadOneMoreInfo()
            }
        })
    }
    
    
    func getBodyMassIndex() -> Void {
        healthStoreManager.getBodyMassIndex(completion: { result, error in
            DispatchQueue.main.async {
                
                if let r = result {
                    
                    self.bodyMassIndex = r
                    
                } else {
                    
                    self.bodyMassIndex = -2
                    
                }
                
                self.loadOneMoreInfo()
                
            }
            
        })
    }
    
    
    func getSleepData() -> Void {
        
        healthStoreManager.getSleepSamples(completion: { samples, error in
            
            DispatchQueue.main.async {
                
                if let samples = samples {
                    let (averageTimeInBed, averageTimeAsleep) = self.calculateAverageTimeInBedAndAsleep(samples: samples)
                    print("Sample Count: \(samples.count)")
                    print("Average time in bed: \(averageTimeInBed) seconds")
                    print("Average time asleep: \(averageTimeAsleep) seconds")
                    
                    self.avgTimeAsleep = averageTimeAsleep
                    self.avgTimeInBed = averageTimeInBed
                }
                
                self.loadOneMoreInfo()
            }
            
        })
        
    }
    
    
    func calculateAverageTimeInBedAndAsleep(samples: [HKCategorySample]) -> (TimeInterval, TimeInterval) {
        
        var totalDurationInBed: TimeInterval = 0
        var totalDurationAsleep: TimeInterval = 0
        
        for sample in samples {
            let duration = sample.endDate.timeIntervalSince(sample.startDate)
            totalDurationInBed += duration
            
            if sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue || sample.value == HKCategoryValueSleepAnalysis.asleepUnspecified.rawValue {
                totalDurationAsleep += duration
            }
        }
        
        let averageTimeInBed = totalDurationInBed / Double(7)
        let averageTimeAsleep = totalDurationAsleep / Double(7)
        
        return (averageTimeInBed, averageTimeAsleep)
    }
    
}
