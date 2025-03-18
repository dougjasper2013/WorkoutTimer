//
//  ContentView.swift
//  WorkoutTimer Watch App
//
//  Created by Douglas Jasper on 2025-03-18.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    
    var body: some View {
        VStack {
            // Picker - Allows user to set the countdown time
            Picker("Set Timer", selection: $timerManager.selectedTime) {
                ForEach(Array(stride(from: 5.00, through: 60.00, by: 1.0)), id: \.self) { time in
                    Text("\(time, specifier: "%.2f") sec").tag(time)
                }
            }
            .labelsHidden()
            .pickerStyle(WheelPickerStyle())
            .frame(height: 80)
            .disabled(timerManager.isRunning) // Disable while running
            
            // Timer Display - Shows hundredths of a second
            Text("\(timerManager.timeRemaining, specifier: "%.2f")")
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding()
            
            // Controls
            HStack {
                Button(action: {
                    timerManager.startTimer()
                }) {
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                }
                
                Button(action: {
                    timerManager.pauseTimer()
                }) {
                    Image(systemName: "pause.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.yellow)
                }
                
                Button(action: {
                    timerManager.resetTimer()
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .background(Color.black)
    }
}


#Preview {
    ContentView()
}
