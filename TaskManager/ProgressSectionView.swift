//
//  ProgressSectionView.swift
//  TaskManager
//
//  Created by Borys Bednarski on 16/06/2024.
//

import SwiftUI

struct ProgressSectionView: View {
    var period: String
    var tasks: [Task]
    var filter: DateFilter
    
    var body: some View {
        let progress = calculateProgress(tasks: tasks, for: filter)
        
        VStack {
            Text("\(period)\(Int(progress * 100))%")
                .font(.caption)
            ProgressView(value: progress)
                .progressViewStyle(ColoredProgressViewStyle(value: progress))
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 5)
    }
    
    func calculateProgress(tasks: [Task], for filter: DateFilter) -> Double {
        let calendar = Calendar.current
        let relevantTasks: [Task]
        
        switch filter {
        case .day:
            relevantTasks = tasks.filter { calendar.isDateInToday($0.dueDate) }
        case .week:
            relevantTasks = tasks.filter {
                calendar.isDate($0.dueDate, equalTo: Date(), toGranularity: .weekOfYear)
            }
        case .month:
            relevantTasks = tasks.filter {
                calendar.isDate($0.dueDate, equalTo: Date(), toGranularity: .month)
            }
        case .other:
            return 0 
        }
        
        guard !relevantTasks.isEmpty else { return 0 }
        
        let completedTasks = relevantTasks.filter { $0.isCompleted }
        return Double(completedTasks.count) / Double(relevantTasks.count)
    }
}

struct ColoredProgressViewStyle: ProgressViewStyle {
    var value: Double
    
    func makeBody(configuration: Configuration) -> some View {
        let color: Color
        switch value {
        case 0..<0.5:
            color = .red
        case 0.5..<1.0:
            color = .orange
        default:
            color = .green
        }
        
        return ProgressView(configuration)
            .accentColor(color)
    }
}
