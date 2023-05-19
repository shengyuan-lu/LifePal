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
    
    let calendar = Calendar.current
    let now = Date()
    
    // A set of HKSampleType that you request authorization for share
    let shareType: Set<HealthKit.HKSampleType> = Set<HealthKit.HKSampleType>()
    
    
    // A set of HKSampleType that you request authorization for read
    let readType: Set<HealthKit.HKObjectType> = [
        HKSampleType.quantityType(forIdentifier: .height)!,
        HKSampleType.quantityType(forIdentifier: .bodyMass)!,
        HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKSampleType.quantityType(forIdentifier: .basalEnergyBurned)!,
        HKSampleType.characteristicType(forIdentifier: .dateOfBirth)!,
        HKSampleType.characteristicType(forIdentifier: .biologicalSex)!,
        HKSampleType.quantityType(forIdentifier: .bodyFatPercentage)!,
        HKSampleType.quantityType(forIdentifier: .bodyMassIndex)!
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
    
    
    func getBirthDate(completion: @escaping (DateComponents?) -> Void) {
        
        do {
            let birthDate = try healthStore?.dateOfBirthComponents()
            completion(birthDate)
        } catch {
            print("Error retrieving birthdate: \(error)")
        }
       
    }
    
    
    func getBiologicalSex(completion: @escaping (HKBiologicalSexObject?) -> Void) {
        
        
        do {
            let bioSex = try healthStore?.biologicalSex()
            completion(bioSex)
        } catch {
            print("Error retrieving biological sex: \(error)")
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

    
    func getActiveCalories(completion: @escaping (Double?, Error?) -> Void) {

        // Define the start and end dates for the current day
        let startDate = calendar.startOfDay(for: now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)

        // Create the quantity type for active energy burned
        let activeEnergyType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)

        // Create the query
        let query = HKStatisticsCollectionQuery(quantityType: activeEnergyType!, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: startDate, intervalComponents: DateComponents(day: 1)) 

        // Set the initial results handler for the query
        query.initialResultsHandler = { query, collection, error in
            if let error = error {
                print("Query error: \(error.localizedDescription)")
                return
            }

            // Iterate over the collection's statistics
            if let statisticsCollection = collection {
                statisticsCollection.enumerateStatistics(from: startDate, to: endDate!, with: { statistics, stop in
                    if let sum = statistics.sumQuantity() {
                        let activityLevel = sum.doubleValue(for: HKUnit.kilocalorie())
                        
                        print("Active Energy Burned Today: \(activityLevel)")
                        
                        completion(activityLevel, error)
                    }
                })
            }
        }
        
        healthStore?.execute(query)
    }
    
    
    func getRestCalories(completion: @escaping (Double?, Error?) -> Void) {
        
        // Define the start and end dates for the current day
        let startDate = calendar.startOfDay(for: now)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)

        // Create the quantity type for base energy burned
        let baseEnergyType = HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)

        // Create the query
        let query = HKStatisticsCollectionQuery(quantityType: baseEnergyType!, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: startDate, intervalComponents: DateComponents(day: 1))

        // Set the initial results handler for the query
        query.initialResultsHandler = { query, collection, error in
            if let error = error {
                print("Query error: \(error.localizedDescription)")
                return
            }

            // Iterate over the collection's statistics
            if let statisticsCollection = collection {
                statisticsCollection.enumerateStatistics(from: startDate, to: endDate!, with: { statistics, stop in
                    if let sum = statistics.sumQuantity() {
                        let activityLevel = sum.doubleValue(for: HKUnit.kilocalorie())
                        
                        print("Rest Energy Burned Today: \(activityLevel)")
                        
                        completion(activityLevel, error)
                    }
                })
            }
        }
        
        healthStore?.execute(query)
    }
    
}
