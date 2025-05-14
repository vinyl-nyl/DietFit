//
//  CardStyleModifier.swift
//  DietFit
//
//  Created by 박동언 on 5/13/25.
//

import SwiftUI

struct CardStyleModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme

    func body(content: Content) -> some View {
        content
            .background(colorScheme == .dark ? Color(.systemGray6) : .white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
//            .shadow(radius: 10, y: 4)
    }
}

