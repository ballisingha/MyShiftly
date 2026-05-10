//
//  ContentView.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 14.02.26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ShiftView()
                .tabItem {
                    Label("Shifts", systemImage: "calendar.badge.clock")
                }
            
            EarningsView()
                .tabItem {
                    Label("Earnings", systemImage: "eurosign.circle.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .tint(.orange) // ← Hier änderst du die Farbe der aktiven Tabs!
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Shift.self, inMemory: true)
}
