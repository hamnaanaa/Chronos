//
//  Task.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import Foundation

class Task: Identifiable, Codable {
    var id = UUID()
    
    var title: String
    var description: String?
    var status: Status
    var category: Category
    var tags: [Tag]
    var dateDue: Date
    var dateCreated: Date
    
    
    init(title: String, description: String?, status: Status, category: Category, tags: [Tag], dateDue: Date, dateCreated: Date = .now) {
        self.title = title
        self.description = description
        self.status = status
        self.category = category
        self.tags = tags
        self.dateDue = dateDue
        self.dateCreated = dateCreated
    }
}
