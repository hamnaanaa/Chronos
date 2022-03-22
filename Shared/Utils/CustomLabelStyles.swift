//
//  CustomLabelStyles.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 23.03.22.
//

import Foundation
import SwiftUI

struct HeadlineLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
                .frame(width: 20, height: 20, alignment: .center)
            configuration.title
        }
        .font(.headline)
    }
}
