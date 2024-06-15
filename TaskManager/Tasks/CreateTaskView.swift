//
//  CreateTaskView.swift
//  TaskManager
//
//  Created by Borys Bednarski on 15/06/2024.
//

import SwiftUI
import SwiftData

struct CreateTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var taskDescription = ""
    @State private var dueDate = Date()
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Info")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $taskDescription)
                }
                
                Section(header: Text("Due Date")) {
                    DatePicker("Select Date", selection: $dueDate, displayedComponents: .date)
                }
            }
            .navigationBarTitle("New Task")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                if title.isEmpty {
                    showAlert = true
                } else {
                    let newTask = Task(title: title, taskDescription: taskDescription, dueDate: dueDate, isCompleted: false)
                    modelContext.insert(newTask)
                    presentationMode.wrappedValue.dismiss()
                }
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Task"), message: Text("Task title is required."), dismissButton: .default(Text("OK")))
            }
        }
    }
}
