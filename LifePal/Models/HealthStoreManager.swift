//
//  HealthStoreManager.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/26/23.
//

import Foundation
import HealthKit

class HealthStoreManager {
    
    var healthStore: HKHealthStore?
    
    let shareType: Set<HealthKit.HKSampleType> = Set<HealthKit.HKSampleType>()
    
    let readType: Set<HealthKit.HKSampleType> = [
        HKSampleType.quantityType(forIdentifier: .height)!,
        HKObjectType.quantityType(forIdentifier: .bodyMass)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
    ]
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
        
        self.requestAuthorization { success in
            if success {
                print("HealthKit Authorization Succeeded")
            } else {
                print("HealthKit Authorization Failed")
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        
        guard let healthStore = self.healthStore else { return completion(false) }
        
        healthStore.requestAuthorization(toShare: self.shareType, read: self.readType) { (success, error) in
            completion(success)
        }
        
    }
    
    func getHeight(unit: HKUnit = HKUnit.meterUnit(with: .centi), completion: @escaping (Double?, Error?) -> Void) {
        
        let heightType = HKSampleType.quantityType(forIdentifier: .height)!
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: heightType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard let sample = results?.first as? HKQuantitySample else {
                print("No height data available")
                return
            }
            
            let height = sample.quantity.doubleValue(for: unit)
            
            print("getHeight: \(height)")
            
            completion(height, error)
        }
        
        healthStore?.execute(query)
    }
    
    func getWeight(unit: HKUnit = HKUnit.gramUnit(with: .kilo), completion: @escaping (Double?, Error?) -> Void) {
        
        let weightType = HKSampleType.quantityType(forIdentifier: .bodyMass)!
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: weightType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard let result = results?.first as? HKQuantitySample else {
                print("No weight data available")
                return
            }
            
            let weight = result.quantity.doubleValue(for: unit)
            
            print("getWeight: \(weight)")

            completion(weight, error)
        }
        
        healthStore?.execute(query)
    }

    func getActiveCalories(unit: HKUnit = HKUnit.largeCalorie(), completion: @escaping (Double?, Error?) -> Void) {
        
        let energyType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: energyType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard let result = results?.first as? HKQuantitySample else {
                print("No calorie data available")
                return
            }
            
            let calories = result.quantity.doubleValue(for: unit) * 1000
            
            print("getCalories: \(calories)")
            
            completion(calories, error)
        }
        
        healthStore?.execute(query)
    }
    
}
