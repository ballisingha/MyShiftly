//
//  Shift.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 04.05.26.
//

import Foundation
import SwiftData

@Model final class Shift: PersistentModel {
    var id: UUID
    var startTime: Date
    var endTime: Date
    var breaks: [Break]
    var notes: String
    
    var duration: TimeInterval {
        endTime.timeIntervalSince(startTime)
    }
    
    var totalBreakTime: TimeInterval {
        breaks.reduce(0) { $0 + $1.duration }
    }
    
    var workingTime: TimeInterval {
        duration - totalBreakTime
    }
    
    init(
        id: UUID = UUID(),
        startTime: Date,
        endTime: Date,
        breaks: [Break] = [],
        notes: String = ""
    ) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.breaks = breaks
        self.notes = notes
    }
}

@Model
final class Break {
    var startTime: Date
    var endTime: Date
    
    var duration: TimeInterval {
        endTime.timeIntervalSince(startTime)
    }
    
    init(startTime: Date, endTime: Date) {
        self.startTime = startTime
        self.endTime = endTime
    }
}
