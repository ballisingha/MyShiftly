//
//  Item.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 14.02.26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var startTime: Date
    var endTime: Date
    var hourlyRate: Double
    
    init(startTime: Date, endTime: Date, hourlyRate: Double) {
        self.startTime = startTime
        self.endTime = endTime
        self.hourlyRate = hourlyRate
    }
}
