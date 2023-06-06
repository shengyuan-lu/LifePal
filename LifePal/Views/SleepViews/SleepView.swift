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
    
    var body: some View {
        
        if sleepVM.hasHealthKitCompletedLoading {
            VStack {
                
                Spacer()
                
                VStack {
                    
                    VStack(spacing: 12) {
                        Text("Set Your Intended Wake Up Time")
                            .font(.headline)
                        
                        Text("For Tomorrow: " + sleepVM.getTodayOrTomorrowDateString(isForTomorrow: true))
                    }

                    
                    DatePicker("Wake Up Time Picker", selection: $sleepVM.wakeUpTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                }
                .padding()
                
                
                NavigationLink {
                    
                    SleepResultView(healthVM: healthVM, sleepVM: sleepVM)
                    
                } label: {
                    
                    Text("Get My Bedtime")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 30)
            
        } else {
            LoadingView()
        }
    }
}
