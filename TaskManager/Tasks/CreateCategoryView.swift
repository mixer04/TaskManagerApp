//
//  CreateCategoryView.swift
//  TaskManager
//
//  Created by Borys Bednarski on 16/06/2024.
//

import SwiftUI

struct CreateCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var selectedColor: Color = .blue

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category Info")) {
                    TextField("Name", text: $name)
                    ColorPicker("Color", selection: $selectedColor)
                }
            }
            .navigationBarTitle("New Category")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                let colorHex = selectedColor.toHexString()
                let newCategory = TaskCategory(name: name, color: colorHex)
                modelContext.insert(newCategory)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

extension Color {
    func toHexString() -> String {
        let components = self.cgColor?.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = (components?.count ?? 0) > 2 ? components?[2] ?? 0.0 : g
        return String(format: "%02X%02X%02X", Int(r * 255.0), Int(g * 255.0), Int(b * 255.0))
    }
}
