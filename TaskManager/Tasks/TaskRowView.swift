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
            Text(task.title)
            Spacer()
            if task.isCompleted {
                Image(systemName: "checkmark")
            }
        }
    }
}
