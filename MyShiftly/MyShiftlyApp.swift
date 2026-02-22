//
//  MyShiftlyApp.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 14.02.26.
//

import SwiftUI
import SwiftData

@main
struct MyShiftlyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [TimeEntry.self])
    }
}
