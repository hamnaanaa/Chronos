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
    
    var color: Color {
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
    
    var name: String {
        rawValue
    }
}
