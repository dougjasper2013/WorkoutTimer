//
//  TimerManager.swift
//  WorkoutTimer Watch App
//
//  Created by Douglas Jasper on 2025-03-18.
//

import Foundation
import Combine
import WatchKit

class TimerManager: ObservableObject {
    @Published var timeRemaining: Int = 30  // Default 30 seconds
    @Published var isRunning = false
    
    private var timer: Timer?
    
    func startTimer() {
        if isRunning { return }
        isRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                WKInterfaceDevice.current().play(.click) // Haptic feedback
            } else {
                self.stopTimer()
                WKInterfaceDevice.current().play(.success) // Completion haptic
            }
        }
    }
    
    func pauseTimer() {
        timer?.invalidate()
        isRunning = false
    }
    
    func resetTimer() {
        timer?.invalidate()
        timeRemaining = 30
        isRunning = false
    }
    
    func stopTimer() {
        timer?.invalidate()
        isRunning = false
    }
}

