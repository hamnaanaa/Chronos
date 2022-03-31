//
//  Epic.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import Foundation
import SwiftUI

struct Epic: Identifiable, Codable {
    var id = UUID()
    
    var title: String
    var description: String
    var color: Color
    /// Category which this epic is associated with
    var category: Category
    
    init(title: String, description: String, color: Color, category: Category) {
        self.title = title
        self.description = description
        self.color = color
        self.category = category
    }
}


extension Epic: Comparable {
    // TODO: better comparator logic?
    static func < (lhs: Epic, rhs: Epic) -> Bool {
        lhs.title < rhs.title
    }
}


/// Mocked data
extension Epic {
    static var exampleEpic1 = Epic(title: "WS2122", description: "Wintersemester 2021", color: .BackgroundColor.purple, category: .education)
    static var exampleEpic2 = Epic(title: "Programming", description: "Everything coding-related", color: .BackgroundColor.orange, category: .projects)
    static var exampleEpic3 = Epic(title: "Swimming", description: "", color: .BackgroundColor.green, category: .freeTime)
    static var exampleEpic4 = Epic(title: "Sport", description: "", color: .BackgroundColor.green, category: .freeTime)

}
