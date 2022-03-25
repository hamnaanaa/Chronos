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
            LazyVGrid(columns: columns) {
                ForEach(tasksContainer.tasks) { task in
                    Text(task.category.name)
                    Text(String(describing: task.status))
                    Text("List of epics")
                    Text(String(describing: task.title))
                    Text(task.description)
                    Text(String(describing: task.dateDue))
                    Text(String(describing: task.dateCreated))
                }
            }
        }
    }
}

struct TasksOverview_Previews: PreviewProvider {
    static var previews: some View {
        let tasksContainer = TasksContainer()
        tasksContainer.reset(using: ([Task.exampleTask1, .exampleTask2, .exampleTask3], []))
        return TasksOverview()
            .environmentObject(tasksContainer)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
