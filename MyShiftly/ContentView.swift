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
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        SheetViewUpdate(currentShift: item)
                    } label: {
                        Text("Am: \(item.startTime, format: Date.FormatStyle(date: .numeric))")
                        Text("Tageslohn \(countHourlyRate(start: item.startTime, end: item.endTime, hourlyRate: item.hourlyRate))")
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
                SheetView()
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
                modelContext.delete(items[index])
            }
        }
    }
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @State private var dateTimeWorkStart = Date.now.addingTimeInterval(-12600)
    @State private var dateTimeWorkEnd = Date.now
    @State private var hourlyRate = 12.00
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            Form {
                Section("Geben Sie Ihren Stundensatz ein:") {
                    TextField("Hello", value: $hourlyRate, format: .currency(code: "EUR"))
                }
                Section {
                    DatePicker("Angefangen um: ", selection: $dateTimeWorkStart)
                }
                Section {
                    DatePicker("Beeendet um: ", selection: $dateTimeWorkEnd)
                }

                Button(action: { addItem() }) {
                    Label("Hinzufügen", systemImage: "checkmark")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }.navigationTitle("Schicht erfassen")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(startTime: dateTimeWorkStart, endTime: dateTimeWorkEnd, hourlyRate: hourlyRate)
            modelContext.insert(newItem)
        }
        dismiss()
    }
}

struct SheetViewUpdate: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var currentShift: Item

    var body: some View {
        NavigationStack {
            Form {
                Section("Geben Sie Ihren Stundensatz ein:") {
                    TextField("Hello", value: $currentShift.hourlyRate, format: .currency(code: "EUR"))
                }
                Section {
                    DatePicker("Angefangen um: ", selection: $currentShift.startTime)
                }
                Section {
                    DatePicker("Beeendet um: ", selection: $currentShift.endTime)
                }

                Button(action: { dismiss() }) {
                    Label("Speichern", systemImage: "checkmark")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }.navigationTitle("Schicht bearbeiten")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
