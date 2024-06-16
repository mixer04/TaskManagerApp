//
//  TaskRowView.swift
//  TaskManager
//
//  Created by Borys Bednarski on 16/06/2024.
//

import SwiftUI

struct TaskRowView: View {
    var task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                Text(task.dueDate, formatter: DateFormatter.taskDateFormatter)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title)
            }
        }
        .padding()
        .cornerRadius(10)
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: Task(title: "Sample Task", taskDescription: "This is a sample task description.", dueDate: Date(), isCompleted: true))
            .previewLayout(.sizeThatFits)
            .padding()
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
