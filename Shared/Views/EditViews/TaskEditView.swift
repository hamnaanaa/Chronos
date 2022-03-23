//
//  TaskEditView.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 16.03.22.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var task: Task
    
    var body: some View {
        Form {
            Section("Task Title") {
                taskTitle
                    .padding()
            }
            
            Section("Category and Status") {
                HStack {
                    taskCategory
                    taskStatus
                }
                .padding()
            }
            
            Section("Dates") {
                HStack {
                    taskDue
                    taskCreated
                }
                .padding()
            }
            
            Section("Epics") {
                taskEpics
            }
            
            Section("Task Description") {
                taskDescription
            }
        }
    }
    
    var taskTitle: some View {
        HStack {
            Spacer()
            TextField("Task title", text: $task.title)
                .font(.title.bold())
            Spacer()
        }
    }
    
    var taskCategory: some View {
        Menu {
            Picker(selection: $task.category, label: EmptyView()) {
                ForEach(Category.allCases, id: \.self) { categoryOption in
                    Text(categoryOption.name)
                        .tag(categoryOption)
                }
            }
        } label: {
            HStack {
                Spacer()
                VStack {
                    Text("Category")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                    
                    HStack {
                        Image(systemName: task.category.iconName)
                        Text(task.category.name)
                    }
                    .font(.title3)
                    .foregroundColor(task.category.color)
                }
                Spacer()
            }
        }
        
    }
    
    var taskStatus: some View {
        Menu {
            Picker(selection: $task.status, label: EmptyView()) {
                ForEach(Status.allCases, id: \.self) { statusOption in
                    Text(statusOption.name)
                        .tag(statusOption)
                }
            }
        } label: {
            HStack {
                Spacer()
                VStack {
                    Text("Status")
                        .font(.title2.bold())
                        .foregroundColor(.primary)
                    Text(task.status.name)
                        .font(.title3)
                        .foregroundColor(task.status.color)
                }
                Spacer()
            }
        }
    }
    
    var taskDue: some View {
        HStack {
            Spacer()
            VStack {
                Text("Due")
                    .font(.title2.bold())
                    .padding(.bottom, -2)
                
                DatePicker("label", selection: $task.dateDue ?? .now, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
            }
            Spacer()
        }
    }
    
    var taskCreated: some View {
        HStack {
            Spacer()
            VStack {
                Text("Created")
                    .font(.title2.bold())
                    .padding(.bottom, -2)
                
                DatePicker("label", selection: $task.dateCreated, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .labelsHidden()
            }
            Spacer()
        }
    }
    
    var taskEpics: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 16) {
                // TODO: "Add epic" button here. Reuse deleted add category button?
                
                ForEach(task.epics) { epic in
                    Text(epic.title)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(epic.color)
                        )
                }
            }
        }
    }
    
    var taskDescription: some View {
        TextEditor(text: $task.description)
            .frame(height: 250)
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(task: .constant(Task(title: "QM -> Daily [07.03.22]",
                                          status: .inPrograss,
                                          category: .work,
                                          epics: [
                                            Epic(title: "WS2122", description: "", color: .BackgroundColor.purple, category: .education),
                                            Epic(title: "TUM", description: "", color: .BackgroundColor.purple, category: .education)
                                          ],
                                          description: "",
                                          dateDue: nil,
                                          dateCreated: .now)
                                    ))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
