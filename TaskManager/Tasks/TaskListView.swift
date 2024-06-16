//
//  TaskListView.swift
//  TaskManager
//
//  Created by Borys Bednarski on 15/06/2024.
//

import SwiftUI
import SwiftData

struct TaskListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var tasks: [Task]
    @State private var showingCreateTaskView = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    ProgressBarsView(tasks: tasks)
                    
                    List {
                        TaskSectionView(title: "Today's Tasks", tasks: tasks, filter: .day)
                        TaskSectionView(title: "This Week's Tasks", tasks: tasks, filter: .week)
                        TaskSectionView(title: "This Month's Tasks", tasks: tasks, filter: .month)
                        TaskSectionView(title: "Other Tasks", tasks: tasks, filter: .other)
                    }
                    .foregroundColor(.primary)
                    .listStyle(.automatic) // Use plain list style// Remove list background
                    .navigationBarTitle("My Tasks")
                    .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                        showingCreateTaskView = true
                    }) {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showingCreateTaskView) {
                        CreateTaskView()
                    }
                }
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

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environment(\.modelContext, MockDataProvider.previewModelContext)
    }
}
