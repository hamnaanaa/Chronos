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
    
    static var exampleTask = Task(title: "Submit final thesis paper", status: .inPrograss, category: .education, epics: [Epic.exampleEpic])
}
