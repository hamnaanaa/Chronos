//
//  CategoryEditView.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 19.03.22.
//

import SwiftUI

struct CategoryEditView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var category: Category
    
    var body: some View {
        ScrollView {
            VStack {
                categoryTitle
                    .padding()
                
                categoryColorGrid
            }
            .padding()
        }
    }
    
    var categoryTitle: some View {
        HStack {
            Spacer()
            TextField("Category title", text: $category.title)
                .font(.title.bold())
            Spacer()
        }
    }
    
    var categoryColorGrid: some View {
        HStack {
            ForEach(Color.TextColor.allColors, id: \.self) { color in
                RoundedRectangle(cornerRadius: 24).foregroundColor(color)
            }
        }
    }
}

struct CategoryEditView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryEditView(category: .constant(Category(title: "Education", iconName: "books.vertical", color: .purple)))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
