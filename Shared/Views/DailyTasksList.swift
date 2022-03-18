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
            
            ForEach(tasksContainer.categories.sorted(by: { $0.title < $1.title })) { category in
                DailyTasksSection(category: category)
            }
            .padding([.leading, .trailing], 20)
            
            // Add category button
            
            AddCategoryButton()
            
            
            Spacer()
        }
    }
    
    struct AddCategoryButton: View {
        @EnvironmentObject var tasksContainer: TasksContainer
        
        /// A flag for displayed an edit sheet for a new category
        @State private var showingAddSheet = false
        /// A category to be edited if the `AddCategoryButton` is pressed
        @State private var newCategory = Category(title: "", iconName: "circle.circle", color: .red)
        
        // TODO: add icon selection functionality here
        var body: some View {
            Button {
                showingAddSheet.toggle()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                    Text("New Category")
                    Spacer()
                }
                .foregroundColor(.gray)
            }
            .sheet(isPresented: $showingAddSheet) {
                NavigationView {
                    CategoryEditView(category: $newCategory)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                // hide the sheet and reset the new task
                                Button("Dismiss") {
                                    showingAddSheet = false
                                    newCategory = Category(title: "", iconName: "circle.circle", color: .red)
                                }
                                .buttonStyle(.bordered)
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                // TODO: add a check for existing category here
                                Button("Add") {
                                    tasksContainer.addCategory(category: newCategory)
                                    showingAddSheet = false
                                    newCategory = Category(title: "", iconName: "circle.circle", color: .red)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                }
            }
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
                    DailyTasksEntry(task: $task)
                }
                AddTaskButton(category: category)
            }
        } label: {
            Text(category.title).foregroundColor(category.color)
        }
    }
    
    struct AddTaskButton: View {
        @EnvironmentObject var tasksContainer: TasksContainer
        
        /// A flag for displayed an edit sheet for a new task
        @State private var showingAddSheet = false
        /// An empty task to be edited if the `AddTaskButton` is pressed
        @State private var newTask = Task(title: "", description: nil, status: .notStarted, category: nil, tags: [], dateDue: nil, dateCreated: .now)
        
        let category: Category
        
        var body: some View {
            Button {
                newTask = Task(title: "", description: nil, status: .notStarted, category: category, tags: [], dateDue: nil, dateCreated: .now)
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
                NavigationView {
                    TaskEditView(task: $newTask)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                // hide the sheet and reset the new task
                                Button("Dismiss") {
                                    showingAddSheet = false
                                    newTask = Task(title: "", description: nil, status: .notStarted, category: category, tags: [], dateDue: nil, dateCreated: .now)
                                }
                                .buttonStyle(.bordered)
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    tasksContainer.addTask(task: newTask)
                                    showingAddSheet = false
                                    newTask = Task(title: "", description: nil, status: .notStarted, category: category, tags: [], dateDue: nil, dateCreated: .now)
                                }
                                .buttonStyle(.bordered)
                            }
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
            .foregroundColor(task.category?.color)
            .sheet(isPresented: $showingEditSheet) {
                NavigationView {
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
                        .navigationBarTitleDisplayMode(.inline)
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
