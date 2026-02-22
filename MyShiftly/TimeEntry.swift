//
//  TimeEntry.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 22.02.26.
//

import Foundation
import SwiftData

@Model
final class TimeEntry {
    var startTime: Date
    var endTime: Date
    
    init(startTime: Date, endTime: Date) {
        self.startTime = startTime
        self.endTime = endTime
    }
}
