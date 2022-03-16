//
//  TaskEditView.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 16.03.22.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.dismiss) private var dismiss
    
    // TODO: where to take it from?
    @Binding var task: Task
    
    var body: some View {
        ScrollView {
            VStack {
                taskTitle
                    .padding()
                
                HStack {
                    taskCategory
                    taskStatus
                }
                .padding()
                
                HStack {
                    taskDue
                    taskCreated
                }
                .padding()
                
                taskDescription
                
                Button("Done") {
                    dismiss()
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    var taskTitle: some View {
        HStack {
            Spacer()
            TextField("title", text: $task.title)
                .font(.title.bold())
            Spacer()
        }
    }
    
    var taskCategory: some View {
        HStack {
            Spacer()
            VStack {
                Text("Category")
                    .font(.title2.bold())
                
                HStack {
                    Image(systemName: task.category?.iconName ?? "questionmark.circle")
                    // TODO: replace with selector button
                    Text(task.category?.title ?? "No Category")
                        .foregroundColor(task.category?.color)
                }
                .font(.title3)
            }
            Spacer()
        }
    }
    
    var taskStatus: some View {
        HStack {
            Spacer()
            VStack {
                Text("Status")
                    .font(.title2.bold())
                Text(task.status.name)
                    .font(.title3)
                    .foregroundColor(task.status.color)
            }
            Spacer()
        }
    }
    
    var taskDue: some View {
        HStack {
            Spacer()
            VStack {
                Text("Due")
                    .font(.title2.bold())
                
                if let dateDue = task.dateDue {
                    Text(dateDue, style: .date)
                        .font(.title3)
                } else {
                    Text("-")
                        .font(.title3)
                }
                
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
                
                Text(task.dateCreated, style: .date)
                    .font(.title3)
                
            }
            Spacer()
        }
    }
    
    // TODO: make it take the whole space!
    var taskDescription: some View {
        TextEditor(text: $task.description ?? "")
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.black)
            )
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(task: .constant(Task(title: "QM -> Daily [07.03.22]", description: nil, status: .inPrograss, category: MockedCategories.work, tags: [], dateDue: .now, dateCreated: .now)))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
