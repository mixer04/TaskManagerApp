//
//  ProgressBarsView.swift
//  TaskManager
//
//  Created by Borys Bednarski on 16/06/2024.
//

import SwiftUI

struct ProgressBarsView: View {
    var tasks: [Task]
    
    var body: some View {
        HStack {
            ProgressSectionView(period: "Today: ", tasks: tasks, filter: .day)
            ProgressSectionView(period: "This Week: ", tasks: tasks, filter: .week)
            ProgressSectionView(period: "This Month: ", tasks: tasks, filter: .month)
        }
        .padding()
    }
}
