//
//  ShiftRow.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 06.05.26.
//

import SwiftUI

struct ShiftRow: View {
    let shift: Shift
    let hourlywage: Double

    var monthSum: Double {
        shift.workingTime / 3600 * hourlywage
    }

    var body: some View {
        let start = shift.startTime.formatted(.dateTime.hour().minute())
        let end = shift.endTime.formatted(.dateTime.hour().minute())
        let hours = shift.workingTime / 3600

        HStack(spacing: 14) {

            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue.opacity(0.15))
                .frame(width: 36, height: 36)
                .overlay(
                    Text("📦")
                        .font(.system(size: 16))
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(shift.startTime, format: .dateTime.day().month())
                    .font(.system(size: 14, weight: .semibold))

                Text("\(start) – \(end) - \(hours)h")
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }

            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text(monthSum, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                    .font(.system(size: 14, weight: .semibold))

                // NFC oder Manuell Badge
                Text(shift.isNfc ? "NFC" : "manuell")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(shift.isNfc ? .green : .secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ShiftRow(shift: Shift(startTime: Date(), endTime: Date().addingTimeInterval(3600), isNfc: true), hourlywage: 12.50)
}
