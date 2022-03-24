//
//  ColorSelectorView.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 21.03.22.
//

import SwiftUI

struct ColorSelectorView: View {
    let colorColumns = Array(repeating: GridItem(.adaptive(minimum: 44), spacing: 12), count: 5)
    
    @Binding var selectedColor: Color
    
    let isBackground: Bool
    
    var body: some View {
        LazyVGrid(columns: colorColumns) {
            ForEach(allColors, id: \.self) { color in
                Button {
                    selectedColor = color
                } label: {
                    color
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(8)
                        .overlay {
                            if color == selectedColor {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.red, lineWidth: 4)
                            }
                        }
                }
                .buttonStyle(.borderless)
            }
        }
        .padding(.vertical)
    }
    
    var allColors: [Color] {
        if isBackground {
            return Color.BackgroundColor.allColors
        } else {
            return Color.TextColor.allColors
        }
    }
}

struct ColorSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectorView(selectedColor: .constant(Color.TextColor.primary), isBackground: false)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
