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
            HStack {
                Text(task.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                if task.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title)
                }
            }
            .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Description")
                    .font(.headline)
                Text(task.taskDescription)
                    .font(.body)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Due Date")
                    .font(.headline)
                Text(task.dueDate, formatter: DateFormatter.taskDateFormatter)
                    .font(.body)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
            
            Toggle("Completed", isOn: $task.isCompleted)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .onChange(of: task.isCompleted) { value in
                    saveTask()
                }
            
            Spacer()
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(20)
        .shadow(radius: 10)
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
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: Task(title: "Sample Task", taskDescription: "This is a sample task description.", dueDate: Date(), isCompleted: false))
            .environment(\.modelContext, MockDataProvider.previewModelContext)
    }
}
