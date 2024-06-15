//
//  Task.swift
//  TaskManager
//
//  Created by Borys Bednarski on 15/06/2024.
//

import SwiftData
import Foundation

@Model
class Task: Identifiable {
    var id: UUID = UUID()
    var title: String
    var taskDescription: String
    var dueDate: Date
    var isCompleted: Bool
    
    init(title: String, taskDescription: String, dueDate: Date, isCompleted: Bool) {
        self.title = title
        self.taskDescription = taskDescription
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}
