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
                AddTaskButton()
                Spacer()
                    .frame(height: TasksTableConstraints.cellHeight / 2)
                TasksTableHeader(sortingPredicate: $sortingPredicate)
                    .frame(height: TasksTableConstraints.cellHeight)
                ForEach($tasksContainer.tasks.sorted(by: sortingPredicate), id: \.self.wrappedValue.id) { $task in
                    TasksTableCell(task: $task)
                        .frame(height: TasksTableConstraints.cellHeight)
                    Divider()
                        .background(Color.BackgroundColor.primary)
                }
            }
            .padding([.horizontal, .top])
        }
    }
    
    struct AddTaskButton: View {
        @EnvironmentObject var tasksContainer: TasksContainer
        
        /// A flag for displayed an edit sheet for a new `Task`
        @State private var showingAddSheet = false
        /// An empty `Epic` to be edited if the `AddTaskButton` is pressed
        @State private var newTask = Task(title: "", status: .notStarted, category: .organisation, epics: [], description: "", dateDue: nil, dateCreated: .now)
        
        var body: some View {
            Button {
                showingAddSheet.toggle()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("New Task")
                    Spacer()
                }
                .font(.headline)
                .frame(height: TasksTableConstraints.cellHeight)
                .foregroundColor(.TextColor.blue)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.BackgroundColor.gray)
                )
            }
            .sheet(isPresented: $showingAddSheet) {
                NavigationView {
                    TaskEditView(task: $newTask)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                // hide the sheet and reset the new task
                                Button("Dismiss", role: .cancel) {
                                    showingAddSheet = false
                                    newTask = Task(title: "", status: .notStarted, category: .organisation, epics: [], description: "", dateDue: nil, dateCreated: .now)
                                }
                                .buttonStyle(.bordered)
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    tasksContainer.addTask(task: newTask)
                                    showingAddSheet = false
                                    newTask = Task(title: "", status: .notStarted, category: .organisation, epics: [], description: "", dateDue: nil, dateCreated: .now)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationViewStyle(.stack)
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
