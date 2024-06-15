//
//  TaskDetailView.swift
//  TaskManager
//
//  Created by Borys Bednarski on 15/06/2024.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var task: Task
    
    init(task: Task) {
        _task = State(initialValue: task)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(task.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Due: \(task.dueDate, formatter: DateFormatter.taskDateFormatter)")
                .font(.subheadline)
            
            Text(task.taskDescription)
                .font(.body)
            
            Toggle("Completed", isOn: $task.isCompleted)
                .onChange(of: task.isCompleted) { value in
                    saveTask()
                }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Task Details", displayMode: .inline)
    }
    
    private func saveTask() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save task: \(error)")
        }
    }
}

extension DateFormatter {
    static let taskDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
