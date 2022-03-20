//
//  AppColors.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 20.03.22.
//

import SwiftUI

/// An extension for `Color` adding app-specific colors for different elements (Text/Background/Selection)
extension Color {

    /// App-specific colors for displaying `Text`
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
    
    // TODO: continue here
    struct BackgroundColor {
        
    }
    
    // TODO: continue here
    struct SelectColor {
        
    }
}
