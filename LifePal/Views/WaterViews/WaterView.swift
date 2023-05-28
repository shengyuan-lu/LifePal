//
//  WaterView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

extension Animation {
    static func ripple() -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(1)
            .delay(0.6)
    }
}

struct WaterView: View {
    
    @ObservedObject var healthVM: HealthVM
    
    @State private var waterLeft: Double = 2.5
    @State private var waterConsumed: Double = 0.0
    @State private var isShowingInputPopup: Bool = false
    @State private var inputText: String = ""
    
    let recommendedWater: Double = 2.5
    
    // FIXME: Change to values obtained from ML model
    
    var body: some View {
        VStack {
            Text("Recommended Water Intake")
                .font(.headline)
            Text("\(recommendedWater, specifier: "%.2f") L")
                .font(.largeTitle)
            
            Spacer()
            
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                Circle()
                    .trim(from: 0, to: CGFloat(min(waterConsumed / recommendedWater, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(waterLeft <= 0 ? Color.green : Color.blue)
                    .rotationEffect(.degrees(-90))
                    .animation(.ripple(), value: CGFloat(min(waterConsumed / recommendedWater, 1.0)))
                    
                VStack{
                    Text("\(waterLeft, specifier: "%.2f") L")
                        .font(.system(size: 60))
                    Text("remaining")
                        .font(.headline)
                }
                
            }
            
            Spacer()
            
            Button(action: {
                isShowingInputPopup = true
            }) {
                Text("I drank water!")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .fixedSize(horizontal: true, vertical: true)
            }
        }
        .padding()
        .sheet(isPresented: $isShowingInputPopup) {
                    VStack {
                        Text("Enter Water Consumed")
                            .font(.headline)
                            .padding()
                        
                        TextField("Amount (in Liters)", text: $inputText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        
                        Button(action: {
                            subtractWater()
                            isShowingInputPopup = false
                        }) {
                            Text("Done")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .frame(width: 300, height: 200)
                    .background(Color.white)
                    .cornerRadius(20)
                }
            }
        
            
            func subtractWater() {
                guard let consumedWater = Double(inputText) else {
                    // FIXME: Handle invalid input
                    return
                }
                
                waterConsumed += consumedWater
                waterLeft = recommendedWater - waterConsumed
                
                // Clear the input text
                inputText = ""
            }
    
    func remainingWater() -> Double {
        return recommendedWater - waterConsumed
    }
}

