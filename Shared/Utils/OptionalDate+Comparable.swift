//
//  OptionalDate+Comparable.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 01.04.22.
//

import Foundation

extension Optional: Comparable where Wrapped == Date {
    /// Compares two optional dates by making a nil always "smaller" than any other date
    public static func < (lhs: Optional, rhs: Optional) -> Bool {
        switch (lhs, rhs) {
        case (nil, nil):
            // TODO: what happens if both are nil?
            return true
        case (nil, .some):
            return true
        case (.some, nil):
            return false
        case (.some(let lhsDate), .some(let rhsDate)):
            return lhsDate < rhsDate
        }
    }
}
