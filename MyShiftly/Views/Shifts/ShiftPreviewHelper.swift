// Eine separate File: ShiftPreviewHelper.swift
// Oder direkt unten in der View-File
import Foundation

#if DEBUG
extension Shift {
    static var preview: Shift {
        Shift(
            startTime: .now,
            endTime: .now.addingTimeInterval(3600 * 3.5),
            breaks: []
        )
    }

    static var previewList: [Shift] {
        [
            Shift(startTime: .now, endTime: .now.addingTimeInterval(3600 * 3.5), breaks: []),
            Shift(
                startTime: .now.addingTimeInterval(-86400),
                endTime: .now.addingTimeInterval(-86400 + 3600 * 4),
                breaks: []
            ),
            Shift(
                startTime: .now.addingTimeInterval(-172_800),
                endTime: .now.addingTimeInterval(-172_800 + 3600 * 2),
                breaks: []
            )
        ]
    }
}
#endif // DEBUG
