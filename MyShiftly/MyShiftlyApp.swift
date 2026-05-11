//
//  MyShiftlyApp.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 14.02.26.
//
import SwiftData
import SwiftUI

@main
struct MyShiftlyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Shift.self])
    }
}
