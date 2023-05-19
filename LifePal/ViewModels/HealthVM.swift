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
    
    private var birthDateComponents: DateComponents = DateComponents()
    
    init() {
        loadData()
    }
    
    
    func loadData() {
        getHeight()
        getWeight()
        getActiveCalories()
        getRestCalories()
        getBirthDateComponents()
    }
    
    
    func getHeight() -> Void {
        
        healthStoreManager.getHeight { result, error in
            
            DispatchQueue.main.async {
                if let r = result {
                    self.height = r
                }
            }
            
        }
    }
    
    
    func getWeight() -> Void {
        
        healthStoreManager.getWeight { result, error in
            
            DispatchQueue.main.async {
                if let r = result {
                    self.weight = r
                }
            }
            
        }
    }
    
    
    func getActiveCalories() -> Void {
        
        healthStoreManager.getActiveCalories { result, error in
            
            DispatchQueue.main.async {
                
                if let r = result {
                    self.activeCalories = r
                }
            }

        }
    }
    
    
    func getRestCalories() -> Void {
        
        healthStoreManager.getRestCalories { result, error in
            
            DispatchQueue.main.async {
                if let r = result {
                    self.restCalories = r
                }
            }
        }
    }
    
    
    func getAge() -> Void {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: self.birthDateComponents.date!, to: Date())
        self.age = ageComponents.year ?? 0
    }
    
    
    func getBirthDateComponents() -> Void {
        
        healthStoreManager.getBirthDate { dateComponent in
            DispatchQueue.main.async {
                if let dc = dateComponent {
                    self.birthDateComponents = dc
                    self.getAge()
                }
            }
        }
        
    }
    
    
}
