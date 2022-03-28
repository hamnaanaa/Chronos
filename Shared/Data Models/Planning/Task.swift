//
//  Task.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    
    var title: String
    var status: Status
    var category: Category
    var epics: [Epic]
    var description: String
    var dateDue: Date?
    var dateCreated: Date
    
    /// A computed property indicating whether this `Task` is completed
    var isCompleted: Bool {
        switch status {
        case .notStarted, .inPrograss, .postponed:
            return false
        case .done, .missed, .cancelled:
            return true
        }
    }
    
    init(title: String, status: Status, category: Category, epics: [Epic], description: String = "", dateDue: Date? = nil, dateCreated: Date = .now) {
        self.title = title
        self.status = status
        self.category = category
        self.epics = epics
        self.description = description
        self.dateDue = dateDue
        self.dateCreated = dateCreated
    }
    
    /// A total number of displayable properties of a `Task`, like its status, title, ...
    static var numOfProps: Int {
        7
    }
}


/// Mocked data
extension Task {
    static var exampleTask1 = Task(
        title: "Submit final thesis paper",
        status: .inPrograss,
        category: .education,
        epics: [Epic.exampleEpic1],
        dateDue: .now.addingTimeInterval(.random(in: 0...10_000_000)),
        dateCreated: .now.addingTimeInterval(.random(in: 0...10_000_000))
    )
    
    static var exampleTask2 = Task(
        title: "Learn more about SwiftUI",
        status: .done,
        category: .projects,
        epics: [Epic.exampleEpic2],
        dateDue: .now.addingTimeInterval(.random(in: 0...10_000_000)),
        dateCreated: .now.addingTimeInterval(.random(in: 0...10_000_000))
    )
    
    static var exampleTask3 = Task(
        title: "Free Swimming",
        status: .cancelled,
        category: .freeTime,
        epics: [Epic.exampleEpic3, .exampleEpic4],
        dateDue: .now.addingTimeInterval(.random(in: 0...10_000_000)),
        dateCreated: .now.addingTimeInterval(.random(in: 0...10_000_000))
    )
    
    static var exampleTaskLongestText = Task(
        title: "Submit final thesis paper regarding the story of my long textual life and then I'll tell you what to do next",
        status: .inPrograss,
        category: .organisation,
        epics: [.exampleEpic1, .exampleEpic2, .exampleEpic3, .exampleEpic4],
        dateDue: ISO8601DateFormatter().date(from: "2022-09-30T10:44:00+0000")!,
        dateCreated: ISO8601DateFormatter().date(from: "2022-09-30T10:44:00+0000")!
    )
}
