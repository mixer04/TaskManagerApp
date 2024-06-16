//
//  TaskCategory.swift
//  TaskManager
//
//  Created by Borys Bednarski on 16/06/2024.
//

import SwiftUI
import SwiftData
import Foundation

@Model
class TaskCategory: Identifiable {
    var id: UUID = UUID()
    var name: String
    var color: String // Use string to save color hex value
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    var uiColor: Color {
        Color(hex: color)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let green = Double((rgbValue & 0xff00) >> 8) / 255.0
        let blue = Double(rgbValue & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
