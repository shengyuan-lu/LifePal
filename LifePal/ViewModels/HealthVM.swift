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
    
    @Published var bodyFatPercentage: Double = -1
    
    @Published var bioSex: String = "Loading..."
    
    private var birthDateComponents: DateComponents = DateComponents()
    private var bioSexObject: HKBiologicalSexObject = HKBiologicalSexObject()
    
    init() {
        loadData()
    }
    
    
    func loadData() {
        getHeight()
        getWeight()
        getActiveCalories()
        getRestCalories()
        getBirthDate()
        getBioSex()
    }
    
    
    func getHeight() -> Void {
        
        healthStoreManager.getHeight { result, error in
            
            DispatchQueue.main.async {
                if let r = result {
                    self.height = r
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
            }
        })
    }
    
    
}
