//
//  ContentView.swift
//  WorkoutTimer Watch App
//
//  Created by Douglas Jasper on 2025-10-20.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    @State private var selectedPresetIndex = 1 // default 5m

    let presets: [TimeInterval] = [60, 5*60, 10*60, 20*60, 30*60]
    let presetLabels: [String]   = ["1m","5m","10m","20m","30m"]

    var body: some View {
        VStack(spacing: 10) {

            // MARK: - Custom segmented row (scrolls if needed)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<presetLabels.count, id: \.self) { idx in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.12)) {
                                selectedPresetIndex = idx
                                timerManager.setDuration(presets[idx])
                            }
                        }) {
                            Text(presetLabels[idx])
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .frame(minWidth: 44)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 10)
                                .background(segmentBackground(for: idx))
                                .clipShape(Capsule())
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 6)
            }
            .frame(maxWidth: .infinity)

            // MARK: - Timer display
            Text(timerManager.formattedRemaining())
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .accessibilityLabel("Remaining time")
                .accessibilityValue(timerManager.formattedRemaining())

            // MARK: - Progress ring
            ProgressView(value: timerManager.progress)
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.15)
                .frame(width: 78, height: 78)

            // MARK: - Controls
            HStack(spacing: 10) {
                Button(action: {
                    timerManager.toggle()
                }) {
                    Label(timerManager.isRunning ? "Pause" : "Start",
                          systemImage: timerManager.isRunning ? "pause.fill" : "play.fill")
                }
                .buttonStyle(.borderedProminent)

                Button(action: {
                    timerManager.reset()
                }) {
                    Label("Reset", systemImage: "arrow.counterclockwise")
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .onAppear {
            // apply the current preset immediately (so the label shows correct time)
            timerManager.setDuration(presets[selectedPresetIndex])
            requestNotificationPermissionIfNeeded()
        }
    }
    
    // <- add this inside the struct
        private func requestNotificationPermissionIfNeeded() {
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { settings in
                guard settings.authorizationStatus != .authorized else { return }
                center.requestAuthorization(options: [.alert, .sound]) { granted, error in
                    // ignore result for now
                }
            }
        }
    // MARK: - Helpers

    @ViewBuilder
    private func segmentBackground(for index: Int) -> some View {
        if selectedPresetIndex == index {
            // selected pill — use accent color
            Capsule()
                .fill(Color.accentColor)
        } else {
            // unselected pill — subtle border
            Capsule()
                .strokeBorder(Color.gray.opacity(0.4), lineWidth: 1)
                .background(Capsule().fill(Color.clear))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
