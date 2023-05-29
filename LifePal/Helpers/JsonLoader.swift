//
//  JsonLoader.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/29/23.
//

import Foundation

class JsonLoader: ObservableObject {
    
    @Published var isLoadingFailed: Bool = false
    
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
