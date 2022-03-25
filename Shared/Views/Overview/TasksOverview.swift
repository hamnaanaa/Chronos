//
//  TasksOverview.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 25.03.22.
//

import SwiftUI

struct TasksOverview: View {
    @EnvironmentObject var tasksContainer: TasksContainer
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem()]) {
                header
                
                ForEach(tasksContainer.tasks) { task in
                    HStack {
                        Text(task.status.name)
                            .frame(width: 150)
                        Text(task.title)
                        
                        Spacer()
                    }
                }
            }
        }
    }
    
    var header: some View {
        HStack {
            Text("Status")
                .frame(width: 150)
            Text("Task")
            Spacer()
        }
        .font(.headline.bold())
    }
}

struct TasksOverview_Previews: PreviewProvider {
    static var previews: some View {
        let tasksContainer = TasksContainer()
        tasksContainer.reset(using: (Array(repeating: Task.exampleTask, count: 20), [Epic.exampleEpic]))
        return TasksOverview()
            .environmentObject(tasksContainer)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
