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
    @Published var calories: Double = 0
    @Published var weight: Double = 0
    
    init() {
        loadData()
    }
    
    func loadData() {
        getHeight()
        getWeight()
        getCalories()
    }
    
    func getHeight() -> Void {
        
        healthStoreManager.getHeight { result, error in
            
            if let r = result {
                self.height = r
            }
            
        }
    }
    
    func getWeight() -> Void {
        
        healthStoreManager.getWeight { result, error in
            
            if let r = result {
                self.weight = r
            }
            
        }
    }
    
    func getCalories() -> Void {
        
        healthStoreManager.getCalories { result, error in
            
            if let r = result {
                self.calories = r
            }

        }
    }
    
    
}
