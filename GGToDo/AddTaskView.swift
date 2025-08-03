//
//  AddTaskView.swift
//  GGToDo
//
//  Created by Gerard Grundy on 3/8/2025.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var title = ""
    @State private var dueDate: Date? = nil

    var body: some View {
        NavigationStack {
            Form {
                TextField("Task title", text: $title)
                DatePicker(
                    "Due Date",
                    selection: Binding(
                        get: { dueDate ?? Date() },
                        set: { dueDate = $0 }
                    ),
                    displayedComponents: .date
                )
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmedTitle.isEmpty else { return }
                        
                        let newTask = Task(title: trimmedTitle, dueDate: dueDate)
                        modelContext.insert(newTask)
                        
                        do {
                            try modelContext.save() // Explicit save, ensures commit before dismiss
                        } catch {
                            print("Error saving task: \(error.localizedDescription)")
                        }
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
#Preview {
    AddTaskView()
}
