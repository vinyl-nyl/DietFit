//
//  ExtractedView.swift
//  DietFit
//
//  Created by 박동언 on 5/13/25.
//

import SwiftUI

struct CardMealButtonView: View {
    @Environment(\.colorScheme) private var colorScheme

    let type: MealType

    var body: some View {
        VStack {
            Button {
                
            } label: {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 25) {
                        Image(systemName: type.icon)
                        Image(systemName: "plus")
                    }
                    .font(.title)
                    .imageScale(.large)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(type.rawValue)
                            .font(.callout)
                        Text("0 Kcal")
                            .font(.headline)
                            .lineLimit(1)
                    }
                }
                .dynamicTypeSize(.large)
            }
            .buttonStyle(.plain)
        }
        .frame(width: 140, height: 130)
        .background(colorScheme == .dark ? .black : Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 20))

    }
}

#Preview {
    CardMealButtonView(type: MealType.breakfast)
}

