//
//  WaterVM.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/28/23.
//

import Foundation

import Foundation
import SwiftUI

class WaterVM: JsonLoader {
    
    @Published var waterSuggestion: Double = -1
    
    @Published var waterRemaining: Double = -1
    @Published var waterConsumed: Double = 0.0
    
    override init() {}
    
    func load(url: String) {
        self.loadRemoteRealData(url: url)
    }
    
    
    func loadRemoteRealData(url: String) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            self.loadRemoteJSON(forURL: url) { data in
                if let d = data {
                    self.loadWater(data: d)
                }
            }
        }
    }
    
    
    func loadWater(data: Data?) -> Void {
        let decoder = JSONDecoder()
        
        do {
            
            if let d = data {
                
                let waterObject = try decoder.decode(Water.self, from: d)
                
                self.waterSuggestion = waterObject.recommendedIntake
                self.waterRemaining = waterObject.recommendedIntake
                
                self.isLoadingFailed = false
                
                print("Success: converted JSON data to water object(s)")
            }
            
        } catch {
            
            self.isLoadingFailed = true
            print("Failed: can't convert JSON data to water object(s)")
            
        }
    }
    
    
    func substractWater(size: WaterSize) {
        waterConsumed += size.rawValue
        substractHelper(amount: size.rawValue)
    }
    
    
    private func substractHelper(amount: Double) {
        
        if self.waterRemaining - amount < 0 {
            self.waterRemaining = 0
        } else {
            self.waterRemaining -= amount
        }
        
    }
    
    
}
