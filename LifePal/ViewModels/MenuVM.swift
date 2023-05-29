//
//  MenuModel.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/16/23.
//

import Foundation
import SwiftUI

class MenuVM: JsonLoader {
    
    @Published var categories: [Category] = [Category]()
    
    private var isRecommeded: Bool
    
    init(isRecommeded: Bool) {
        self.isRecommeded = isRecommeded
    }
    
    
    func load(url: String) {
        self.loadRemoteRealData(url: url)
    }
    
    func loadRemoteRealData(url: String) {
        
        self.categories.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            
            if self.isRecommeded {
                
                self.loadRemoteJSON(forURL: url) { data in
                    if let d = data {
                        self.loadMenu(data: d)
                    }
                }
                
            } else {
                
                self.loadRemoteJSON(forURL: Links.fullMenuAPI) { data in
                    if let d = data {
                        self.loadMenu(data: d)
                    }
                }
                
            }
        }
    }
    
    
    func loadLocalDemoData() {
        
        self.categories.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            if self.isRecommeded {
                
                let data: Data? =  self.loadLocalJSON(forName: Links.menuRecommendLocalSample)
                
                self.loadMenu(data: data)
                
            } else {
                let data: Data? =  self.loadLocalJSON(forName: Links.fullMenuLocalSample)
                
                self.loadMenu(data: data)
            }
        }
    }
    
    // MARK: - JSON Parsing
    func loadMenu(data: Data?) -> Void {
        let decoder = JSONDecoder()
        
        do {
            
            if let d = data {
                
                self.categories = try decoder.decode([Category].self, from: d)
                
                self.isLoadingFailed = false
                print("Success: converted JSON data to category object(s)")
            }
            
        } catch {
            
            self.isLoadingFailed = true
            print("Failed: can't convert JSON data to category object(s)")
            
        }
    }
    

    
}
