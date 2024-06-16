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
        ZStack {
            PurpleGlassBackgroundView(isCompleted: task.isCompleted)
                .zIndex(0)  // Ensure the background is at the lowest layer
            VStack(alignment: .leading, spacing: 20) {
                // Title and Description section
                VStack(alignment: .leading, spacing: 10) {
                    Text(task.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(task.taskDescription)
                        .font(.body)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                // Due date section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Due Date")
                        .font(.headline)
                    Text(task.dueDate, formatter: DateFormatter.taskDateFormatter)
                        .font(.body)
                
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cornerRadius(10)
                }
                .padding()
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                // Completed toggle section
                Toggle("Completed", isOn: $task.isCompleted)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thickMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .onChange(of: task.isCompleted) { value in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            saveTask()
                        }
                    }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Task Details", displayMode: .inline)
            .zIndex(1)  // Ensure content is above the background
        }
    }
    
    private func saveTask() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save task: \(error)")
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: Task(title: "Sample Task", taskDescription: "This is a sample task description.", dueDate: Date(), isCompleted: false))
            .environment(\.modelContext, MockDataProvider.previewModelContext)
    }
}
