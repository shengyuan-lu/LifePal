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
    
    // A set of HKSampleType that you request authorization for share
    let shareType: Set<HealthKit.HKSampleType> = Set<HealthKit.HKSampleType>()
    
    // A set of HKSampleType that you request authorization for read
    let readType: Set<HealthKit.HKObjectType> = [
        HKSampleType.quantityType(forIdentifier: .height)!,
        HKSampleType.quantityType(forIdentifier: .bodyMass)!,
        HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKSampleType.quantityType(forIdentifier: .basalEnergyBurned)!,
        HKSampleType.characteristicType(forIdentifier: .dateOfBirth)!
    ]
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        } else {
            print("Health Data is not available")
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
    
    func getAge() {
        
        do {
            let dobComponents = try healthStore?.dateOfBirthComponents()
            
            dobComponents?.date
            
        } catch {
            
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
            
            print("Height: \(height)")
            
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
            
            print("Weight: \(weight)")

            completion(weight, error)
        }
        
        healthStore?.execute(query)
    }

    func getActiveCalories(unit: HKUnit = HKUnit.largeCalorie(), completion: @escaping (Double?, Error?) -> Void) {
        
        let energyType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: energyType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard let result = results?.first as? HKQuantitySample else {
                print("No actvie calorie data available")
                return
            }
            
            let calories = result.quantity.doubleValue(for: unit) * 1000
            
            print("Active Calories: \(calories)")
            
            completion(calories, error)
        }
        
        healthStore?.execute(query)
    }
    
    func getRestCalories(unit: HKUnit = HKUnit.largeCalorie(), completion: @escaping (Double?, Error?) -> Void) {
        
        let energyType = HKSampleType.quantityType(forIdentifier: .basalEnergyBurned)!
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: energyType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, results, error) in
            
            guard let result = results?.first as? HKQuantitySample else {
                print("No rest calorie data available")
                return
            }
            
            let calories = result.quantity.doubleValue(for: unit) * 1000
            
            print("Rest Calories: \(calories)")
            
            completion(calories, error)
        }
        
        healthStore?.execute(query)
    }
    
}
