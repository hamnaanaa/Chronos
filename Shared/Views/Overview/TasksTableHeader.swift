//
//  TasksTableHeader.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 30.03.22.
//

import SwiftUI

struct TasksTableHeader: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                Divider().background(Color.BackgroundColor.primary)
                HStack {
                    // category
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        categoryHeader
                            .frame(
                                width: geo.size.width * TasksTableConstraints.categoryWidth,
                                alignment: .leading
                            )
                    }
                    // status
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        statusHeader
                            .frame(
                                width: geo.size.width * TasksTableConstraints.statusWidth,
                                alignment: .leading
                            )
                    }
                    // title
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        titleHeader
                            .frame(
                                width: geo.size.width * TasksTableConstraints.titleWidth,
                                alignment: .topLeading
                            )
                            .multilineTextAlignment(.leading)
                    }
                    // epics
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        epicsHeader
                            .frame(
                                width: geo.size.width * TasksTableConstraints.epicsWidth,
                                alignment: .leading
                            )
                    }
                    // dateDue
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        dateDueHeader
                            .frame(
                                width: geo.size.width * TasksTableConstraints.dateDueWidth
                            )
                    }
                    // dateCreated
                    Group {
                        Divider().background(Color.BackgroundColor.primary)
                        dateCreatedHeader
                            .frame(
                                width: geo.size.width * TasksTableConstraints.dateCreatedWidth
                            )
                        Divider().background(Color.BackgroundColor.primary)
                    }
                }
                Divider().background(Color.BackgroundColor.primary)
            }
        }
    }
    
    // TODO: REFACTOR: consider creating an App-wide container for all icon names and generic stuff in one place
    
    var categoryHeader: some View {
        Label("Category", systemImage: "arrowtriangle.down.circle.fill")
            .labelStyle(HeadlineLabelStyle())
    }
    
    var statusHeader: some View {
        Label("Status", systemImage: "arrowtriangle.down.circle.fill")
            .labelStyle(HeadlineLabelStyle())
    }
    
    var titleHeader: some View {
        Label("Task", systemImage: "arrowtriangle.down.circle.fill")
            .labelStyle(HeadlineLabelStyle())
    }
    
    var epicsHeader: some View {
        Label("Epics", systemImage: "arrowtriangle.down.circle.fill")
            .labelStyle(HeadlineLabelStyle())
    }
    
    var dateDueHeader: some View {
        Label("Due", systemImage: "arrowtriangle.down.circle.fill")
            .labelStyle(HeadlineLabelStyle())
    }
    
    var dateCreatedHeader: some View {
        Label("Created", systemImage: "arrowtriangle.down.circle.fill")
            .labelStyle(HeadlineLabelStyle())
    }
}

struct TasksTableHeader_Previews: PreviewProvider {
    static var previews: some View {
        TasksTableHeader()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
