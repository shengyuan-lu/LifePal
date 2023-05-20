//
//  MenuModel.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/16/23.
//

import Foundation
import SwiftUI

class MenuVM: ObservableObject {
    
    @Published var categories: [Category] = [Category]()
    @Published var isLoadingFailed: Bool = false
    
    private var isRecommeded: Bool
    
    init(isRecommeded: Bool) {
        self.isRecommeded = isRecommeded
    }
    
    func load(url: String) {
        self.loadRemoteRealData(url: url)
    }
    
    func loadRemoteRealData(url: String) {
        
        self.categories.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
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
    
    // JSON loading
    func loadLocalJSON(forName name:String) -> Data? {
        
        do {
            
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL)
                
                print("Success: load local JSON (name: \(name) to data succeessfully)")
                
                return data
            }
            
        } catch {
            self.isLoadingFailed = true
            print("Failed: Can't parse local JSON to data: \(error.localizedDescription)")
            
        }
        
        return nil
    }
    
    
    func loadRemoteJSON(forURL urlString: String, completionBlock: @escaping (Data?) -> Void) -> Void {
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            
            self.isLoadingFailed = true
            
            print("Failed: invalid url string \(urlString) when loading remote JSON")
            
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil || data == nil {
                
                DispatchQueue.main.async {
                    self.isLoadingFailed = true
                }
                
                print("Failed: Can't get data task with URL \(url!)")
                
                return
            }
            
            DispatchQueue.main.async {
                completionBlock(data)
            }
        }
        
        dataTask.resume()
    }
    
}
