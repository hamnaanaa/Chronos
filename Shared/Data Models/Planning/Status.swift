//
//  Status.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import Foundation
import SwiftUI

enum Status: String, CaseIterable, Codable {
    
    static var allCases: [Status] = [notStarted, inPrograss, done, postponed, missed, cancelled]
    
    case notStarted = "not started"
    case inPrograss = "in progress"
    case done = "done"
    case postponed = "postponed"
    case missed = "missed"
    case cancelled = "cancelled"
    
    var color: Color {
        switch self {
        case .notStarted:
            return .yellow
        case .inPrograss:
            return .green
        case .done:
            return .blue
        case .postponed:
            return .purple
        case .missed:
            return .red
        case .cancelled:
            return .gray
        }
    }
    
    var name: String {
        rawValue
    }
}
