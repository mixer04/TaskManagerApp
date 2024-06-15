//
//  MockDataProvider.swift
//  TaskManager
//
//  Created by Borys Bednarski on 16/06/2024.
//

import SwiftData
import Foundation

class MockDataProvider {
    static var previewModelContext: ModelContext {
        do {
            let modelContainer = try ModelContainer(for: Task.self)
            let context = ModelContext(modelContainer)
            
            let tasks = [
                Task(title: "Buy groceries", taskDescription: "Buy milk, eggs, and bread", dueDate: Date(), isCompleted: false),
                Task(title: "Finish report", taskDescription: "Complete the quarterly financial report", dueDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, isCompleted: false),
                Task(title: "Doctor's appointment", taskDescription: "Annual check-up", dueDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!, isCompleted: true)
            ]
            tasks.forEach { context.insert($0) }
            
            return context
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
}
