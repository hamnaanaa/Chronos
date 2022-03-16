//
//  MockedData.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 16.03.22.
//

import Foundation

enum MockedCategories {
    case entry(Category)
    
    static var allCategories = [education, work, freeTime, organisation]
    
    static var education = Category(title: "Education", iconName: "books.vertical", color: .purple)
    static var work = Category(title: "Work & Finances", iconName: "laptopcomputer", color: .blue)
    static var freeTime = Category(title: "Free Time", iconName: "face.dashed", color: .green)
    static var organisation = Category(title: "Organisation", iconName: "gear.circle", color: .orange)
}

class MockedTasks: ObservableObject {
    @Published var allTasks = [
        Task(title: "QM -> Daily [07.03.22]", description: nil, status: .done, category: MockedCategories.work, tags: [], dateDue: .now, dateCreated: .now),
        Task(title: "BT → Infrastructure Chapter", description: nil, status: .inPrograss, category: MockedCategories.education, tags: [], dateDue: .now, dateCreated: .now)
    ]
}
