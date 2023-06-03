//
//  Links.swift
//  LifePal
//
//  Created by Shengyuan Lu on 5/16/23.
//

import Foundation

struct Links {
    
    // Remote Real API Endpoints
    static let menuRecommendationAPI = "http://3.15.22.210:8000/api/foodrec/?user=$user$&weight=$weight$&bodyfat=$bodyfat$&avg_activity=$avg_activity$&cb=2&cl=2&cd=2"
    
    static let fullMenuAPI = "http://3.15.22.210:8000/api/menu"
    
    static let waterRecommendationAPI = "http://3.15.22.210:8000/api/waterrec/?user=$user$&age=$age$&weight=$weight$&height=$height$&avg_activity=$avg_activity$&temperature=25"
    
    static let sleepRecommendationAPI = "http://3.15.22.210:8000/api/sleeprec/?user=$user$&avg_asleep=$avg_asleep$&avg_inbed=$avg_inbed$&avg_activity=$avg_activity$&wake_time=$wake_time$"
    
    // Remote Demo API Endpoints
    static let menuRecommendationAPISample = "http://3.15.22.210:8000/api/recommendfood?weight=55&bodyfat=0.165&avg_activity=300"
    
    // Local Demo JSON Filenames
    static let fullMenuLocalSample = "FullMenuSample"
    static let menuRecommendLocalSample = "MLFoodRecommendationSample"
}
