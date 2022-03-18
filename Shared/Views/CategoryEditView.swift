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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CategoryEditView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryEditView(category: .constant(Category(title: "Education", iconName: "books.vertical", color: .purple)))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
