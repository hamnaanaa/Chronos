//
//  TasksOverview.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 25.03.22.
//

import SwiftUI

struct TasksOverview: View {
    @EnvironmentObject var tasksContainer: TasksContainer
    
    let columns = Array(repeating: GridItem(.flexible()), count: Task.numOfProps)
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach($tasksContainer.tasks) { $task in
                    TasksTableCell(task: $task)
                    // TODO: use correct width
                    Divider()
                        .background(Color.TextColor.primary)
                        
                }
            }
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
