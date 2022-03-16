//
//  Status.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import Foundation
import SwiftUI

enum Status: CaseIterable, Codable {
    case value(Color)
    
    static var allCases: [Status] = [notStarted, inPrograss, done, postponed, missed, cancelled]
    
    // pre-defined values
    static let notStarted = Status.value(.yellow)
    static let inPrograss = Status.value(.green)
    static let done = Status.value(.blue)
    static let postponed = Status.value(.purple)
    static let missed = Status.value(.red)
    static let cancelled = Status.value(.gray)
}
