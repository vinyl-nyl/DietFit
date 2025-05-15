//
//  CardMealButtonView.swift
//  DietFit
//
//  Created by 박동언 on 5/13/25.
//

import SwiftUI

struct CardMealButtonView: View {
    @Environment(\.colorScheme) private var colorScheme

    let mealtype: MealType
    let typeCalories: Int

    var body: some View {
        NavigationLink {
            AddMealView(mealType: mealtype)
                .modifier(StyleModifier())
        } label: {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 25) {
                    Image(systemName: mealtype.icon)
                    Image(systemName: "plus")
                }
                .font(.title)
                .imageScale(.large)

                VStack(alignment: .leading, spacing: 2) {
                    Text(mealtype.rawValue)
                        .font(.callout)
                    Text("\(typeCalories) Kcal")
                        .font(.headline)
                        .lineLimit(1)
                }
            }
            .dynamicTypeSize(.large)
            .frame(width: 140, height: 130)
            .background(colorScheme == .dark ? .black : Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .buttonStyle(.plain)


    }
}

#Preview {
    NavigationStack {
        CardMealButtonView(mealtype: MealType.breakfast, typeCalories: 100)
    }
}

