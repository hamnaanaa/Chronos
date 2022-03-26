//
//  TasksTableCell.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 25.03.22.
//

import SwiftUI

struct TasksTableCell: View {
    @Binding var task: Task
    
    private let columnsAlignment = [
        GridItem(.fixed(150), alignment: .topLeading),
        GridItem(.fixed(150), alignment: .topLeading),
        GridItem(.flexible(), alignment: .topLeading),
        GridItem(.fixed(300), alignment: .topLeading),
        GridItem(.fixed(130), alignment: .topLeading),
        GridItem(.fixed(130), alignment: .topLeading)
    ]
    
    var body: some View {
        LazyVGrid(columns: columnsAlignment) {
            categorySection
            statusSection
            titleSection
            epicsSection
            dateDueSection
            dateCreatedSection
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
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
            return Text(dateDue, style: .date)
        } else {
            return Text("")
        }
    }
    
    private var dateCreatedSection: some View {
        Text(task.dateCreated, style: .date)
    }
}

struct TasksTableCell_Previews: PreviewProvider {
    static var previews: some View {
        TasksTableCell(task: .constant(Task.exampleTask1))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
