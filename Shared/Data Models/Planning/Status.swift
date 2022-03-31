//
//  Status.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import Foundation
import SwiftUI

enum Status: String, CaseIterable, Codable {    
    case notStarted = "not started"
    case inPrograss = "in progress"
    case done = "done"
    case postponed = "postponed"
    case missed = "missed"
    case cancelled = "cancelled"
    
    var textColor: Color {
        switch self {
        case .notStarted:
            return .TextColor.yellow
        case .inPrograss:
            return .TextColor.green
        case .done:
            return .TextColor.blue
        case .postponed:
            return .TextColor.purple
        case .missed:
            return .TextColor.red
        case .cancelled:
            return .TextColor.gray
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .notStarted:
            return .BackgroundColor.yellow
        case .inPrograss:
            return .BackgroundColor.green
        case .done:
            return .BackgroundColor.blue
        case .postponed:
            return .BackgroundColor.purple
        case .missed:
            return .BackgroundColor.red
        case .cancelled:
            return .BackgroundColor.gray
        }
    }
    
    var name: String {
        rawValue
    }
}


extension Status: Comparable {
    // TODO: better comparator logic?
    static func < (lhs: Status, rhs: Status) -> Bool {
        lhs.name < rhs.name
    }
}
