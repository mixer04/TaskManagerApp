//
//  ArchivedTaskSectionView.swift
//  TaskManager
//
//  Created by Borys Bednarski on 16/06/2024.
//

import SwiftUI

struct ArchivedTaskSectionView: View {
    @Environment(\.modelContext) private var modelContext
    var title: String
    var tasks: [Task]
    
    var body: some View {
        let archivedTasks = tasks.filter { $0.dueDate < Date() }
        
        if !archivedTasks.isEmpty {
            Section(header: Text(title)) {
                ForEach(archivedTasks) { task in
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        TaskRowView(task: task)
                            .listRowBackground(Color.clear) // Ensures list rows respect custom backgrounds
                    }
                }
                .onDelete { offsets in
                    deleteTasks(at: offsets, in: archivedTasks)
                }
            }
        }
    }
    
    func deleteTasks(at offsets: IndexSet, in archivedTasks: [Task]) {
        for index in offsets {
            if let taskIndex = tasks.firstIndex(where: { $0.id == archivedTasks[index].id }) {
                modelContext.delete(tasks[taskIndex])
            }
        }
    }
}
