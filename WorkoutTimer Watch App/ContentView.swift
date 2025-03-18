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
            Text("\(timerManager.timeRemaining)")
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding()
            
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
