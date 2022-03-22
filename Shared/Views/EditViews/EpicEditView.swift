//
//  EpicEditView.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 22.03.22.
//

import SwiftUI

struct EpicEditView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var epic: Epic
    
    var body: some View {
        Form {
            Section("Title") {
                epicTitle
                    .padding()
            }
            
            Section("Color") {
                ColorSelectorView(selectedColor: $epic.color)
            }
        }
    }
    
    var epicTitle: some View {
        HStack {
            Spacer()
            TextField("Epic title", text: $epic.title)
                .font(.title.bold())
            Spacer()
        }
    }
}

struct EpicEditView_Previews: PreviewProvider {
    static var previews: some View {
        EpicEditView(epic: .constant(Epic(title: "WS2021", description: "Wintersemester 2021", color: .TextColor.purple, category: .education)))
    }
}
