//
//  SleepResultView.swift
//  LifePal
//
//  Created by Shengyuan Lu on 6/5/23.
//

import SwiftUI

struct SleepResultView: View {
    
    @ObservedObject var healthVM: HealthVM
    @ObservedObject var sleepVM: SleepVM
    
    var body: some View {
        
        if sleepVM.hasAPIcallCompleted {
            
            VStack(spacing: 12) {
                Spacer()
                
                Text("Your Recommended Bedtime: ")
                    .font(.headline)
                
                if let sleep = sleepVM.sleep {
                    
                    Text(sleep.getBedTime() ?? "")
                        .font(.largeTitle)
                        .bold()
                    
                    if sleep.isBedtimeValid() {
                        if !sleep.isSameDay() {
                            Text("On Today " + sleepVM.getTodayOrTomorrowDateString(isForTomorrow: false))
                        } else {
                            Text("On Tomorrow " + sleepVM.getTodayOrTomorrowDateString(isForTomorrow: true))
                        }
                    }
                    
                }
                
                Spacer()
            }
            .onDisappear {
                self.sleepVM.hasAPIcallCompleted = false
                self.sleepVM.sleep = nil
            }
            
        } else {
            LoadingView()
                .onAppear {
                    sleepVM.load()
                }
        }
        
    }
}
