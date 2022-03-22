//
//  Category.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable, Codable {
    case education = "Education"
    case work = "Work"
    case projects = "Projects"
    case organisation = "Organisation"
    case freeTime = "Free Time"
    
    var color: Color {
        switch self {
        case .education:
            return .TextColor.purple
        case .work:
            return .TextColor.blue
        case .projects:
            return .TextColor.orange
        case .organisation:
            return .TextColor.yellow
        case .freeTime:
            return .TextColor.green
        }
    }
    
    var iconName: String {
        switch self {
        case .education:
            return "graduationcap.fill"
        case .work:
            return "laptopcomputer"
        case .projects:
            return "gear.circle.fill"
        case .organisation:
            return "tray.fill"
        case .freeTime:
            return "person.circle.fill"
        }
    }
    
    var name: String {
        rawValue
    }
}
