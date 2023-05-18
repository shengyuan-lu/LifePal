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
    
    @Published var height: Double = 0
    @Published var age: Double = 0
    @Published var weight: Double = 0
    
    @Published var activeCalories: Double = 0
    @Published var restCalories: Double = 0
    
    init() {
        loadData()
    }
    
    func loadData() {
        getHeight()
        getWeight()
        getActiveCalories()
        getRestCalories()
    }
    
    func getAge() -> Void {
        self.age = 20
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
    
    
}
