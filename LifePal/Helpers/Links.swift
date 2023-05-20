//
//  Links.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/16/23.
//

import Foundation

struct Links {
    
    // Remote Real API Endpoints
    static let menuRecommendationAPI = "http://3.15.22.210:8000/api/recommendfood?weight=$weight$&bodyfat=$bodyfat$&avg_activity=$avg_activity$"
    static let fullMenuAPI = "http://3.15.22.210:8000/api/menu"

    // Remote Demo API Endpoints
    static let menuRecommendationAPISample = "http://3.15.22.210:8000/api/recommendfood?weight=55&bodyfat=0.165&avg_activity=300"
    
    // Local Demo JSON Filenames
    static let fullMenuLocalSample = "FullMenuSample"
    static let menuRecommendLocalSample = "MLFoodRecommendationSample"
}
