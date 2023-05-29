//
//  WaterView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI
import ConfettiSwiftUI

struct WaterView: View {
    
    @ObservedObject var healthVM: HealthVM
    @ObservedObject var waterVM: WaterVM
    
    @State private var counter: Int = 0
    
    var body: some View {
        
        
        if waterVM.waterSuggestion == -1 {
            
            LoadingView()
            
        } else {
            
            VStack {
                
                VStack(spacing: 4) {
                    ProfileViewDataCell(label: "Goal Intake", data: waterVM.waterSuggestion, unit: "L")
                    Divider()
                    ProfileViewDataCell(label: "Current Intake", data: waterVM.waterConsumed, unit: "L")
                }

                Spacer()
                
                ZStack {
                    
                    Circle()
                        .stroke(lineWidth: 30)
                        .opacity(waterVM.waterRemaining != 0 ? 0.3 : 1.0)
                        .foregroundColor(waterVM.waterRemaining != 0 ? Color.gray : Color.green)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(waterVM.waterRemaining / waterVM.waterSuggestion))
                        .stroke(style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.blue)
                        .rotationEffect(.degrees(-90))
                        .animation(.ripple(), value: CGFloat(min(waterVM.waterConsumed / waterVM.waterSuggestion, 1.0)))
                    
                    VStack(spacing: 8) {
                        
                        if waterVM.waterRemaining != 0 {
                            
                            Text("Remaining")
                                .font(.title3)
                                .bold()
                            
                            Text("\(waterVM.waterRemaining, specifier: "%.2f") L")
                                .font(.largeTitle)
                            
                        } else {
                            Text("Goal Reached!")
                                .font(.largeTitle)
                                .bold()
                                .confettiCannon(counter: $counter, num: 50, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200, repetitions: 3)
                        }

                    }
                    .onChange(of: waterVM.waterRemaining) { newValue in
                        if waterVM.waterRemaining == 0 {
                            counter += 1
                        }
                    }
                    
                }
                .padding(30)
                
                Spacer()
                
                HStack {
                    
                    Button {
                        self.waterVM.substractWater(size: .mouthful)
                        
                    } label: {
                        
                        VStack(spacing: 8) {
                            Image(systemName: "mouth.fill")
                            Text("Mouthful")
                                .bold()
                        }
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.white)
                        .background(Color.orange)
                        .clipShape(Circle())
                    }
                    
                    Button {
                        self.waterVM.substractWater(size: .cup)
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "cup.and.saucer.fill")
                            Text("Cup")
                                .bold()
                        }
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.white)
                        .background(Color.pink)
                        .clipShape(Circle())
                    }
                    
                    
                    Button {
                        self.waterVM.substractWater(size: .bottle)
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "mug.fill")
                            Text("Mug")
                                .bold()
                        }
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.white)
                        .background(Color.purple)
                        .clipShape(Circle())
                    }
                    .padding(.bottom, 12)
                    
                }
                
            }
            .padding()
        }
        
        
    }
    
}

