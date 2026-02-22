//
//  ContentView.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 14.02.26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    @Environment(\.modelContext) private var modelContext
    @Query private var timeEntrys: [TimeEntry]
    @State private var hourlyRate = 13.90
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Aktueller Stundenlohn")
                    TextField("Hello", value: $hourlyRate, format: .currency(code: "EUR"))
                        .frame(width: 70, height: 40)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                List {
                    ForEach(timeEntrys) { timeEntry in
                        NavigationLink {
                            TimeEntryEditorView(timeEntry: timeEntry)
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Am: \(timeEntry.startTime, format: Date.FormatStyle(date: .numeric)) \(countHourlyRate(start: timeEntry.startTime, end: timeEntry.endTime, hourlyRate: hourlyRate))")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: { showingSheet.toggle() }) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingSheet) {
                    TimeEntryEditorView()
                }.navigationTitle("Schichten")
            }
        }
    }

    private func countHourlyRate(start: Date, end: Date, hourlyRate: Double) -> String {
        let seconds = end.timeIntervalSince(start)
        guard seconds > 0 else { return "0,00 €" }

        let hours = seconds / 3600.0
        let totalEarned = hours * hourlyRate

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.locale = Locale(identifier: "de_DE")

        return formatter.string(from: NSNumber(value: totalEarned)) ?? "0,00 €"
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(timeEntrys[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TimeEntry.self, inMemory: true)
}
