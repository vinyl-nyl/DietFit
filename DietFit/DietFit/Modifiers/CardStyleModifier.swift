//
//  CardStyleModifier.swift
//  DietFit
//
//  Created by 박동언 on 5/13/25.
//

import SwiftUI

struct CardStyleModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    func body(content: Content) -> some View {

        Group {
            if horizontalSizeClass == .regular {
                content
                    .frame(width: 400)
                    .padding(50)
            } else {
                content
                    .padding(20)
            }
        }
        .background(colorScheme == .dark ? Color(.systemGray6) : .white)
        .clipShape(RoundedRectangle(cornerRadius: 20))

    }
}


