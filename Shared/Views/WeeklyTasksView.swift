//
//  WeeklyTasksView.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import SwiftUI

struct WeeklyTasksView: View {
    
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    let weekDays = [
        "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "A"
    ]
    
    // TODO: add animation. Press on day and it zooms into fullscreen mode
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(weekDays, id: \.self) { day in
                    DailyTasksList(day: day)
                        .frame(minHeight: 400)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(.secondary, lineWidth: 2)
//                        )
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
