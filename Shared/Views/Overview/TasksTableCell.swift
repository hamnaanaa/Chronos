//
//  TasksTableCell.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 25.03.22.
//

import SwiftUI

struct TasksTableCell: View {
    @Binding var task: Task
    
    @State private var showingTaskSheet = false
    
    var body: some View {
        GeometryReader { geo in
            Button {
                showingTaskSheet = true
            } label: {
                HStack {
                    // category
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        categorySection
                            .frame(
                                width: geo.size.width * TasksTableConstraints.categoryWidth,
                                alignment: .leading
                            )
                    }
                    // status
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        statusSection
                            .frame(
                                width: geo.size.width * TasksTableConstraints.statusWidth,
                                alignment: .leading
                            )
                    }
                    // title
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        titleSection
                            .frame(
                                width: geo.size.width * TasksTableConstraints.titleWidth,
                                alignment: .topLeading
                            )
                            .multilineTextAlignment(.leading)
                    }
                    // epics
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        epicsSection
                            .frame(
                                width: geo.size.width * TasksTableConstraints.epicsWidth,
                                alignment: .leading
                            )
                    }
                    // dateDue
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        dateDueSection
                            .frame(
                                width: geo.size.width * TasksTableConstraints.dateDueWidth
                            )
                    }
                    // dateCreated
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        dateCreatedSection
                            .frame(
                                width: geo.size.width * TasksTableConstraints.dateCreatedWidth
                            )
                        Divider().background(Color.BackgroundColor.primary)
                    }
                }
            }
            .sheet(isPresented: $showingTaskSheet) {
                Text("Hi!")
            }
        }
    }
    
    private var categorySection: some View {
        Text(task.category.name)
            .foregroundColor(task.category.textColor)
    }
    
    private var statusSection: some View {
        Text(task.status.name)
            .foregroundColor(task.status.textColor)
    }
    
    private var titleSection: some View {
        Text(task.title)
            .font(.headline.bold())
            .foregroundColor(.TextColor.primary)
    }
    
    private var epicsSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 4) {
                // TODO: include new epic button?
                // AddEpicButton(task: $task)
                
                // all other epics
                ForEach($task.epics) { $epic in
                    NavigationLink(destination: EpicEditView(epic: $epic)) {
                        Text(epic.title)
                            .padding(.vertical, 4)
                            .padding(.horizontal)
                            .foregroundColor(.TextColor.primary)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(epic.color)
                            )
                    }
                }
            }
        }
    }
    
    private var dateDueSection: some View {
        if let dateDue = task.dateDue {
            return Text(dateDue, format: .dateTime.year().month().day())
                .foregroundColor(.TextColor.primary)
        } else {
            return Text("")
        }
    }
    
    private var dateCreatedSection: some View {
        Text(task.dateCreated,
             format: .dateTime.year().month().day())
            .foregroundColor(.TextColor.primary)
    }
}

struct TasksTableCell_Previews: PreviewProvider {
    static var previews: some View {
        TasksTableCell(task: .constant(Task.exampleTaskLongestText))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
