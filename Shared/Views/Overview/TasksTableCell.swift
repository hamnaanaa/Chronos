//
//  TasksTableCell.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 25.03.22.
//

import SwiftUI

struct TasksTableCell: View {
    @Binding var task: Task
    
    var body: some View {
        HStack {
            Group {
                Divider().background(Color.TextColor.primary)
                categorySection
                    .frame(width: 100)
            }
            Group {
                Divider().background(Color.TextColor.primary)
                statusSection
                    .frame(width: 100)
            }
            Group {
                Divider().background(Color.TextColor.primary)
                titleSection
                    .frame(width: 290, alignment: .topLeading)
                    .multilineTextAlignment(.leading)
            }
            Group {
                Divider().background(Color.TextColor.primary)
                epicsSection
                    .frame(width: 300, alignment: .leading)
            }
            Group {
                Divider().background(Color.TextColor.primary)
                dateDueSection
                    .frame(width: 140)
            }
            Group {
                Divider().background(Color.TextColor.primary)
                dateCreatedSection
                    .frame(width: 140)
                Divider().background(Color.TextColor.primary)
            }
        }
        .frame(height: 45, alignment: .center)
        .hoverEffect()
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
        } else {
            return Text("")
        }
    }
    
    private var dateCreatedSection: some View {
        Text(task.dateCreated,
             format: .dateTime.year().month().day())
    }
}

struct TasksTableCell_Previews: PreviewProvider {
    static var previews: some View {
        TasksTableCell(task: .constant(Task.exampleTaskLongestText))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
