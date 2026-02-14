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
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
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
        } detail: {
            Text("Select an item")
        }
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
                Section("Geben Sie Ihren Stundensatz ein:"){
                    
                    TextField("Hello", value: $hourlyRate, format: .currency(code: "EUR") )
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
            let newItem = Item(timestamp: dateTimeWorkEnd)
            modelContext.insert(newItem)
        }
        dismiss()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
