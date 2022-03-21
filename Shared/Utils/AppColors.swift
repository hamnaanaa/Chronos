//
//  AppColors.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 20.03.22.
//

import SwiftUI

/// An extension for `Color` adding app-specific colors for different elements (Text/Background/Selection)
extension Color {

    /// App-specific colors for displaying text
    struct TextColor {
        static let blue = Color("TextBlue")
        static let brown = Color("TextBrown")
        static let gray = Color("TextGray")
        static let green = Color("TextGreen")
        static let orange = Color("TextOrange")
        static let pink = Color("TextPink")
        static let primary = Color("TextPrimary")
        static let purple = Color("TextPurple")
        static let red = Color("TextRed")
        static let yellow = Color("TextYellow")
        
        /// List of all supported `TextColor` values
        static var allColors: [Color] {
            [TextColor.blue,
             TextColor.brown,
             TextColor.gray,
             TextColor.green,
             TextColor.orange,
             TextColor.pink,
             TextColor.primary,
             TextColor.purple,
             TextColor.red,
             TextColor.yellow]
        }
    }
    
    /// App-specific colors for displaying background
    struct BackgroundColor {
        static let blue = Color("BGBlue")
        static let brown = Color("BGBrown")
        static let gray = Color("BGGray")
        static let green = Color("BGGreen")
        static let orange = Color("BGOrange")
        static let pink = Color("BGPink")
        static let primary = Color("BGPrimary")
        static let purple = Color("BGPurple")
        static let red = Color("BGRed")
        static let yellow = Color("BGYellow")
        
        /// List of all supported `BackgroundColor` values
        static var allColors: [Color] {
            [BackgroundColor.blue,
             BackgroundColor.brown,
             BackgroundColor.gray,
             BackgroundColor.green,
             BackgroundColor.orange,
             BackgroundColor.pink,
             BackgroundColor.primary,
             BackgroundColor.purple,
             BackgroundColor.red,
             BackgroundColor.yellow]
        }
    }
}
