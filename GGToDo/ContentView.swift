//
//  ContentView.swift
//  GGToDo
//
//  Created by Gerard Grundy on 3/8/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [Task]
    @State private var showingAddTask = false
    @State private var showCompleted = true

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(tasks.filter { showCompleted || !$0.isCompleted }) { task in
                    HStack {
                        Button {
                            withAnimation {
                                task.isCompleted.toggle()
                                task.dateCompleted = task.isCompleted ? Date() : nil
                            }
                        } label: {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                        }
                        .buttonStyle(.plain)

                        NavigationLink {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(task.title)
                                    .font(.title)
                                if let completedDate = task.dateCompleted {
                                    Text("Completed on \(completedDate.formatted(date: .long, time: .shortened))")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                        } label: {
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .strikethrough(task.isCompleted)
                                if let dueDate = task.dueDate {
                                    Text(dueDate, style: .date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteTasks)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: { showingAddTask = true }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Toggle("Show Completed", isOn: $showCompleted)
                        .toggleStyle(.switch)
                }
            }
        } detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $showingAddTask) {
            AddTaskView()
        }
    }

    // Removed addTask() function; now using sheet for adding tasks.

    private func deleteTasks(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(tasks[index])
            }
        }
    }
   
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self, inMemory: true)
}
