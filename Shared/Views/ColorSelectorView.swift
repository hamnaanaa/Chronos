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
    
    var body: some View {
        LazyVGrid(columns: colorColumns) {
            // TODO: better logic for selecting Text vs. Background color
            ForEach(Color.TextColor.allColors, id: \.self) { color in
                Button {
                    selectedColor = color
                } label: {
                    color
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(8)
                }
                .buttonStyle(.borderless)
            }
        }
        .padding(.vertical)
    }
}

struct ColorSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectorView(selectedColor: .constant(Color.TextColor.primary))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
