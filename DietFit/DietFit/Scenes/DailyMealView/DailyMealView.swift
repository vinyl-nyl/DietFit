//
//  DailyMealView.swift
//  DietFit
//
//  Created by 박동언 on 5/12/25.
//

import SwiftUI

struct DailyMealView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.colorScheme) private var colorScheme

    @StateObject private var mealVM = DailyMealViewModel()

    let mealTypes = MealType.allCases

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 상단 바 - 날짜 선택, 유저 아이콘
                VStack(spacing: 0) {
                    HStack {
                        DatePickerButtonView(mealVM: mealVM)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    ScrollCalendarView(mealVM: mealVM)
                }
                .background(Color(.systemGray6))

                ScrollView {
                    VStack(spacing: 16) {
                        // 통계
                        CardSummaryView()

                        // 식단
                        VStack(spacing: 16) {
                            Text("오늘의 식단")
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 40)

                            Grid(horizontalSpacing: 20, verticalSpacing: 20) {
                                ForEach(0..<2) { row in
                                    GridRow {
                                        ForEach(0..<2) { col in
                                            CardMealButtonView(type: mealTypes[row * 2 + col])

                                        }
                                    }
                                }
                            }
                        }
                        .frame(width: 360, height: 360)
                        .modifier(CardStyleModifier())

                        // 메모
                        CardMemoView()
                    }
                    .padding(.top)

                    .frame(maxWidth: .infinity)
                }
                .scrollIndicators(.hidden)
                .background(colorScheme == .dark ? .black : Color(.systemGray6))
//                .navigationDestination(for: MealType.self) { type in
//                    AddMealView(type: type)
//                }
            }
        }
    }
}

func dateFormat(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "M.d E"
    return formatter.string(from: date)
}

#Preview {
    DailyMealView()
}
