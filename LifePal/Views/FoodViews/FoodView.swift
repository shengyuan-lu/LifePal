//
//  FoodView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

struct FoodView: View {
    
    @ObservedObject var healthVM: HealthVM
    @ObservedObject var menu: MenuModel
    
    var body: some View {
        MenuView(menu: menu)
    }
    
}
