//
//  TasksOverview.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 25.03.22.
//

import SwiftUI

struct TasksOverview: View {
    @EnvironmentObject var tasksContainer: TasksContainer
    
    @State private var sortingPredicate: (Binding<Task>, Binding<Task>) -> Bool = { $0.wrappedValue.dateCreated < $1.wrappedValue.dateCreated }
    
    let columns = Array(repeating: GridItem(.flexible()), count: Task.numOfProps)
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                TasksTableHeader(sortingPredicate: $sortingPredicate)
                    .frame(height: TasksTableConstraints.cellHeight)
                ForEach($tasksContainer.tasks.sorted(by: sortingPredicate)) { $task in
                    TasksTableCell(task: $task)
                        .frame(height: TasksTableConstraints.cellHeight)
                    Divider()
                        .background(Color.BackgroundColor.primary)
                }
            }
            .padding([.horizontal, .top])
        }
    }
}

struct TasksOverview_Previews: PreviewProvider {
    static var previews: some View {
        let tasksContainer = TasksContainer()
        tasksContainer.reset(using: (TasksContainer.mockedTasks, TasksContainer.mockedEpics))
        return TasksOverview()
            .environmentObject(tasksContainer)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
