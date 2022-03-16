//
//  Binding+Optionals.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 16.03.22.
//

import Foundation
import SwiftUI

// Overload the ??-operator to support optional bindings
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
