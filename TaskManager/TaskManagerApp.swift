//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Borys Bednarski on 15/06/2024.
//

import SwiftUI
import SwiftData

@main
struct TaskManagerApp: App {
    var body: some Scene {
        WindowGroup {
            TaskListView()
                .modelContainer(for: Task.self)
        }
    }
}
