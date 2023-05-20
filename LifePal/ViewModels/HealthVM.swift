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
    
    @Published var bioSex: String = "Loading..."
    
    private var loadedInfoCount: Int = 0
    @Published var isLoadingComplete: Bool = false
    
    private var birthDateComponents: DateComponents = DateComponents()
    private var bioSexObject: HKBiologicalSexObject = HKBiologicalSexObject()
    
    init() {
        load()
    }
    
    func load() {
        
        self.loadedInfoCount = 0
        self.isLoadingComplete = false
        
        getHeight()
        getWeight()
        
        getActiveCalories()
        getRestCalories()
        getAvgActiveCalories()
        
        getBirthDate()
        getBioSex()
        getBodyFat()
        getBodyMassIndex()
    }
    
    func loadOneMoreInfo() {
        self.loadedInfoCount += 1
        
        if self.loadedInfoCount == 9 {
            self.isLoadingComplete = true
        }
    }
    
    func getMenuRecommendationAPIString() -> String {
        
        var apiString = Links.menuRecommendationAPI
        
        apiString = apiString.replacingOccurrences(of: "$weight$", with: String(Int(weight)))
        apiString = apiString.replacingOccurrences(of: "$bodyfat$", with: String(bodyFatPercentage))
        apiString = apiString.replacingOccurrences(of: "$avg_activity$", with: String(Int(avgActiveCalories)))
        
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
    
    
}
