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
    var description: String?
    var status: Status
    var category: Category?
    var epics: [Epic]
    var dateDue: Date?
    var dateCreated: Date
    
    
    init(title: String, description: String?, status: Status, category: Category?, epics: [Epic], dateDue: Date? = nil, dateCreated: Date = .now) {
        self.title = title
        self.description = description
        self.status = status
        self.category = category
        self.epics = epics
        self.dateDue = dateDue
        self.dateCreated = dateCreated
    }
}
