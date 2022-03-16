//
//  Category.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import Foundation
import SwiftUI

struct Category: Identifiable, Codable {
    var id = UUID()
    
    var title: String
    var iconName: String
    var color: Color
    
    init(title: String, iconName: String, color: Color) {
        self.title = title
        self.iconName = iconName
        self.color = color
    }
}
