//
//  SleepView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 4/17/23.
//

import SwiftUI

struct SleepView: View {
    
    @ObservedObject var healthVM: HealthVM
    @ObservedObject var sleepVM: SleepVM
    
    //    @State private var wakeUpTime = Date()
    //    @State private var recommendedBedTime = ""
    
    //    private var bedtimeCalculator: BedtimeCalculator {
    //            BedtimeCalculator()
    //        }
    
    var body: some View {
        VStack {
            Text("Sleep Calculator")
                .font(.largeTitle)
                .padding(.top, 50) // Add top padding to title
            
            Spacer()
            
            VStack {
                Text("Wake Up Time")
                    .font(.headline)
                
                DatePicker("", selection: $sleepVM.wakeUpTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
            }
            .padding()
            
            Button(action: sleepVM.calculateBedtime) {
                Text("Calculate Bedtime")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
            
            Text("Recommended Bedtime:")
                .font(.headline)
            
            Text(sleepVM.recommendedBedTime)
                .font(.title)
            
            Spacer()
        }
        .padding(.horizontal, 30) // Add horizontal padding to the entire VStack
    }
}
