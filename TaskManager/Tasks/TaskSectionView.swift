//
//  TaskSectionView.swift
//  TaskManager
//
//  Created by Borys Bednarski on 16/06/2024.
//

import SwiftUI

struct TaskSectionView: View {
    @Environment(\.modelContext) private var modelContext
    var title: String
    var tasks: [Task]
    var filter: DateFilter
    
    var body: some View {
        let filteredTasks = filterTasks(tasks: tasks, for: filter)
        
        if !filteredTasks.isEmpty {
            Section(header: Text(title)) {
                ForEach(filteredTasks) { task in
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        TaskRowView(task: task)
                    }
                }
                .onDelete { offsets in
                    deleteTasks(at: offsets, in: filteredTasks)
                }
            }
        }
    }
    
    func filterTasks(tasks: [Task], for filter: DateFilter) -> [Task] {
        let calendar = Calendar.current
        
        switch filter {
        case .day:
            return tasks.filter { calendar.isDateInToday($0.dueDate) }
        case .week:
            return tasks.filter {
                calendar.isDate($0.dueDate, equalTo: Date(), toGranularity: .weekOfYear) && !calendar.isDateInToday($0.dueDate)
            }
        case .month:
            return tasks.filter {
                calendar.isDate($0.dueDate, equalTo: Date(), toGranularity: .month) &&
                !calendar.isDate($0.dueDate, equalTo: Date(), toGranularity: .weekOfYear)
            }
        case .other:
            return tasks.filter {
                calendar.compare($0.dueDate, to: Date(), toGranularity: .month) == .orderedDescending &&
                !calendar.isDate($0.dueDate, equalTo: Date(), toGranularity: .month)
            }
        }
    }
    
    func deleteTasks(at offsets: IndexSet, in filteredTasks: [Task]) {
        for index in offsets {
            if let taskIndex = tasks.firstIndex(where: { $0.id == filteredTasks[index].id }) {
                modelContext.delete(tasks[taskIndex])
            }
        }
    }
}
