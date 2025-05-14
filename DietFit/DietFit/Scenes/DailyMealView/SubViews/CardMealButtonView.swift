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
    let width: CGFloat
    
    var body: some View {
            Button {

            } label: {
                VStack(alignment: .leading, spacing: width * 0.04) {
                    HStack(spacing: width * 0.075) {
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
                    }
                }
            }
            .frame(width: width * 0.35, height: width * 0.32)
            .background(colorScheme == .dark ? .black : Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .buttonStyle(.plain)

    }
}

#Preview {
    CardMealButtonView(type: MealType.breakfast, width: 360)
}

