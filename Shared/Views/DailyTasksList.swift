//
//  DailyTasksList.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import SwiftUI

struct TextDivider: View {
    let label: String
    let horizontalPadding: CGFloat
    let color: Color
    
    init(label: String, horizontalPadding: CGFloat = 20, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }
    
    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }
    
    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}

struct DailyTasksList: View {
    @EnvironmentObject var tasksContainer: TasksContainer
    
    /// Associated day for this tasks list
    let day: String
    
//    /// Handler for persistently storing tasks from this view
//    let saveAction: () -> Void
    // Used to detect app inactivity to store the data persistenly
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Text(day)
                        .font(.title.bold())
                    Spacer()
                }
                .padding(.bottom, 10)
                
                Divider()
                
                ForEach(MockedCategories.allCategories) { category in
                    DailyTasksSection(category: category)
                }
                .padding([.leading, .trailing], 20)
                
                Spacer()
            }
            .onChange(of: scenePhase) { phase in
                print("[DEBUG: \(Date.now)] Saving all tasks into persistent storage")
                if phase == .inactive { tasksContainer.saveAll() }
            }
        }
    }
    
    struct DailyTasksSection: View {
        @EnvironmentObject var tasksContainer: TasksContainer
        
        @State private var isExpanded = false
        
        let category: Category
        
        var body: some View {
            DisclosureGroup(isExpanded: $isExpanded) {
                VStack {
                    ForEach(tasksContainer.tasks.filter { $0.category.title == category.title }) { task in
                        DailyTasksEntry(task: task, parentColor: category.color)
                    }
                    AddTaskButton(color: category.color)
                }
            } label: {
                Text(category.title).foregroundColor(category.color)
            }
        }
        
        struct AddTaskButton: View {
            @EnvironmentObject var tasksContainer: TasksContainer
            
            let color: Color
            
            var body: some View {
                Button {
                    // TODO: implement
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Text("New Task")
                        Spacer()
                        Spacer()
                    }
                    .foregroundColor(color)
                }
            }
        }
        
        struct DailyTasksEntry: View {
            // TODO: add more complex checkmark logic here with more squares
            // e.g. long press for failed
            @State private var isDone = false
            @State private var text = ""
            
            var task: Task
            
            let parentColor: Color
            
            // TODO: if isDone -> ~text~ and other background color?
            var body: some View {
                HStack {
                    Button {
                        isDone.toggle()
                    } label: {
                        Image(systemName: isDone ? "checkmark.square" : "square")
                    }
                    
                    // TODO: onChange update task!
                    
                    TextField("", text: $text)
                    Spacer()
                }
                .foregroundColor(parentColor)
            }
        }
}

struct DailyTasksList_Previews: PreviewProvider {
    static var previews: some View {
        DailyTasksList(day: "Tuesday")
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(TasksContainer())
    }
}
