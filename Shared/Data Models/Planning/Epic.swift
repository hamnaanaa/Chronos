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
