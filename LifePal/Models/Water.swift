//
//  Water.swift
//  LifePal
//
//  Created by Arkin Jai Singh Verma on 5/27/23.
//

import Foundation

struct Water: Decodable, Hashable {
    
    let recommendedIntake: Double
    let unit: String
    let id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case recommendedIntake = "recommended intake"
        case unit = "unit"
    }
    
    
}
