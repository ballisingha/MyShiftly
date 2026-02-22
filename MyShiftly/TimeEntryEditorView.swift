import SwiftUI
import SwiftData

struct TimeEntryEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let timeEntry: TimeEntry?

    @State private var dateTimeWorkStart: Date
    @State private var dateTimeWorkEnd: Date
    
    init(timeEntry: TimeEntry? = nil) {
        self.timeEntry = timeEntry
        _dateTimeWorkStart = State(initialValue: timeEntry?.startTime ?? Date.now.addingTimeInterval(-12600))
        _dateTimeWorkEnd = State(initialValue: timeEntry?.endTime ?? Date.now)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    DatePicker("Angefangen um: ", selection: $dateTimeWorkStart, displayedComponents: [.date, .hourAndMinute])
                }
                Section {
                    DatePicker("Beendet um: ", selection: $dateTimeWorkEnd, displayedComponents: [.date, .hourAndMinute])
                }

                Button(action: { save() }) {
                    Label("Speichern", systemImage: "checkmark")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(.borderedProminent)
            }.navigationTitle(timeEntry == nil ? "Neue Schicht" : "Schicht bearbeiten")
        }
    }
    private func save() {
        if let timeEntry {
            timeEntry.startTime = dateTimeWorkStart
            timeEntry.endTime = dateTimeWorkEnd
        } else {
            let newEntry = TimeEntry(
                startTime: dateTimeWorkStart,
                endTime: dateTimeWorkEnd
            )

            modelContext.insert(newEntry)
        }

        dismiss()
    }
}

#Preview {
    let modelContainer = try! ModelContainer(for: TimeEntry.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let context = modelContainer.mainContext
    let sample = TimeEntry(startTime: .now.addingTimeInterval(-3600), endTime: .now)
    context.insert(sample)

    return TimeEntryEditorView(timeEntry: sample)
        .modelContainer(modelContainer)
}
