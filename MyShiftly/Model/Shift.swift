//
//  Shift.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 04.05.26.
//

import Foundation
import SwiftData

@Model final class Shift {
    // MARK: - Properties
    
    /// When the shift started
    var startTime: Date
    
    /// When the shift ended
    var endTime: Date
    
    /// All breaks taken during this shift
    var breaks: [ShiftBreak]
    
    /// Optional notes about the shift
    var notes: String
    
    var isNfc: Bool = false
    
    // MARK: - Computed Properties
    
    /// Total duration of the shift (including breaks)
    var duration: TimeInterval {
        endTime.timeIntervalSince(startTime)
    }
    
    /// Sum of all break durations
    var totalBreakTime: TimeInterval {
        breaks.reduce(0) { $0 + $1.duration }
    }
    
    /// Actual working time (duration minus breaks)
    var workingTime: TimeInterval {
        duration - totalBreakTime
    }
        
    // MARK: - Initialization
    
    init(
        startTime: Date,
        endTime: Date,
        breaks: [ShiftBreak] = [],
        notes: String = "",
        isNfc: Bool = false
    ) {
        self.startTime = startTime
        self.endTime = endTime
        self.breaks = breaks
        self.notes = notes
        self.isNfc = isNfc
    }
}

// MARK: - ShiftBreak Model

@Model
final class ShiftBreak {
    /// When the break started
    var startTime: Date
    
    /// When the break ended
    var endTime: Date
    
    /// Duration of the break
    var duration: TimeInterval {
        endTime.timeIntervalSince(startTime)
    }
    
    init(startTime: Date, endTime: Date) {
        self.startTime = startTime
        self.endTime = endTime
    }
}
