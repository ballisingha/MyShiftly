//
//  ShiftView.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 05.05.26.
//

import SwiftData
import SwiftUI

struct ShiftView: View {
    @Environment(\.modelContext) private var context // ← Punkt fehlte!
    @Query(sort: \Shift.startTime, order: .reverse) var shifts: [Shift]

    var settings: Settings {
        Settings.loadOrCreate(in: context)
    }

    var groupedShifts: [String: [Shift]] {
        Dictionary(grouping: shifts) { shift in
            shift.startTime.formatted(.dateTime.month(.wide).year())
        }
    }

    var monthSum: Double {
        let currentMonth = Date.now.formatted(.dateTime.month(.wide).year())
        return shifts
            .filter { $0.startTime.formatted(.dateTime.month(.wide).year()) == currentMonth }
            .reduce(0) { $0 + $1.workingTime / 3600 * settings.hourlyWage }
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Schichten")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading)
                    Spacer()
                    Button(action: {
                        // Action for adding a new shift
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .frame(width: 30, height: 30)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .padding(.trailing)
                }

                HStack {
                    Button(action: {
                        // Action for adding a new shift
                    }) {
                        Text("Alle")
                            .font(.title3)
                            .frame(width: 60, height: 33)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(.capsule)
                    }
          
                    Button(action: {
                        // Action for adding a new shift
                    }) {
                        Text("April 2026")
                            .font(.subheadline)
                            .frame(width: 85, height: 33)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(.capsule)
                    }

                    Button(action: {
                        // Action for adding a new shift
                    }) {
                        Text("März 2026")
                            .font(.footnote)
                            .frame(width: 85, height: 33)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(.capsule)
                    }

                    Button(action: {
                        // Action for adding a new shift
                    }) {
                        Text("Feb 2026")
                            .font(.footnote)
                            .frame(width: 85, height: 33)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(.capsule)
                    }
                }
                List {
                    ForEach(groupedShifts.keys.sorted().reversed(), id: \.self) { month in
                        Section("\(month) - \(groupedShifts[month]!.count) Schichten - \(monthSum.formatted(.currency(code: Locale.current.currency?.identifier ?? "EUR")))") {
                            ForEach(groupedShifts[month]!) { shift in
                                ShiftRow(shift: shift, hourlywage: settings.hourlyWage)
                            }
                        }
                    }
                }.listStyle(.insetGrouped)
            }
        }
    }
}
// swiftlint:disable line_length force_try
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Shift.self, configurations: config)

    Shift.previewList.forEach { container.mainContext.insert($0) }

    return ShiftView()
        .modelContainer(container)
}
// swiftlint:enable line_length force_try
