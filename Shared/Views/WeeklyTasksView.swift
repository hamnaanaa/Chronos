//
//  WeeklyTasksView.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import SwiftUI

struct WeeklyTasksView: View {
    @EnvironmentObject var tasksContainer: TasksContainer
    
    let columns = Array(repeating: GridItem(.flexible(), alignment: .top), count: 4)
    
    let weekDays = [
        "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "ANY"
    ]
    
    // TODO: add animation. Press on day and it zooms into fullscreen mode
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(weekDays, id: \.self) { day in
                    VStack {
                        DailyTasksList(day: day)
                            .frame(minHeight: 350)
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}

struct WeeklyTasksView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyTasksView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
