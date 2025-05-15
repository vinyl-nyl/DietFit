//
//  StyleModifier.swift
//  DietFit
//
//  Created by 박동언 on 5/15/25.
//

import SwiftUI

struct StyleModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    func body(content: Content) -> some View {
        Group {
            if horizontalSizeClass == .regular {
                content
                    .frame(width: 500)
            } else {
                content
            }
        }
        .padding()
    }
}
