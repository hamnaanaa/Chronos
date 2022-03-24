//
//  DailyTasksList.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import SwiftUI

struct DailyTasksList: View {
    @EnvironmentObject var tasksContainer: TasksContainer
    
    /// Associated day for this tasks list
    let day: String
    
    var body: some View {
        VStack {
            // day title section
            
            HStack {
                Spacer()
                Text(day)
                    .font(.title.bold())
                Spacer()
            }
            .padding(.bottom, 10)
            
            Divider()
            
            // categories section
            
            ForEach(Category.allCases, id: \.self) { category in
                DailyTasksSection(category: category)
            }
            .padding([.leading, .trailing], 20)
            
            Spacer()
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
                ForEach($tasksContainer.tasks) { $task in
                    if isFittingTask(task) {
                        DailyTasksEntry(task: $task)
                    }
                }
                .padding(.vertical, 4)
                
                AddTaskButton(category: category)
            }
        } label: {
            Label(category.name, systemImage: category.iconName)
                .labelStyle(HeadlineLabelStyle())
        }
        .accentColor(category.color)
    }
    
    /// Helper function to test if the given task belongs to this `DailyTasksSection`
    private func isFittingTask(_ task: Task) -> Bool {
        task.category == category
    }
    
    struct AddTaskButton: View {
        @EnvironmentObject var tasksContainer: TasksContainer
        
        /// A flag for displayed an edit sheet for a new `Task`
        @State private var showingAddSheet = false
        /// An empty `Epic` to be edited if the `AddTaskButton` is pressed
        @State private var newTask = Task(title: "", status: .notStarted, category: .organisation, epics: [], description: "", dateDue: nil, dateCreated: .now)
        
        let category: Category
        
        var body: some View {
            Button {
                newTask = Task(title: "", status: .notStarted, category: category, epics: [], description: "", dateDue: nil, dateCreated: .now)
                showingAddSheet.toggle()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("New Task")
                    Spacer()
                    Spacer()
                }
                .foregroundColor(category.color)
            }
            .sheet(isPresented: $showingAddSheet) {
                TaskEditView(task: $newTask)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            // hide the sheet and reset the new task
                            Button("Dismiss", role: .cancel) {
                                showingAddSheet = false
                                newTask = Task(title: "", status: .notStarted, category: category, epics: [], description: "", dateDue: nil, dateCreated: .now)
                            }
                            .buttonStyle(.bordered)
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                tasksContainer.addTask(task: newTask)
                                showingAddSheet = false
                                newTask = Task(title: "", status: .notStarted, category: category, epics: [], description: "", dateDue: nil, dateCreated: .now)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
            }
        }
    }
    
    struct DailyTasksEntry: View {
        @EnvironmentObject var tasksContainer: TasksContainer
        
        // TODO: add more complex checkmark logic here with more squares
        // e.g. long press for failed
        @State private var isDone = false
        
        @State private var showingEditSheet = false
        
        @Binding var task: Task
        
        // TODO: if isDone -> ~text~ and other background color?
        var body: some View {
            HStack {
                Button {
                    // TODO: use task binding with improved logic
                    isDone.toggle()
                } label: {
                    Image(systemName: isDone ? "checkmark.square" : "square")
                }
                
                TextField("", text: $task.title)
                    .onLongPressGesture {
                        showingEditSheet = true
                    }
                Spacer()
            }
            .foregroundColor(task.category.color)
            .sheet(isPresented: $showingEditSheet) {
                TaskEditView(task: $task)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            // hide the sheet and reset the new task
                            Button("Delete", role: .destructive) {
                                showingEditSheet = false
                                tasksContainer.removeTask(task: task)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
            }
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
