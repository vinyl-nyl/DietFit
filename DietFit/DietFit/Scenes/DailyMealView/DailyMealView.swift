//
//  DailyMealView.swift
//  DietFit
//
//  Created by 박동언 on 5/12/25.
//

import SwiftUI
import SwiftData

struct DailyMealView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var mealVM: DailyMealViewModel

    @Query private var records: [MealRecord]

    let Mealtypes = MealType.allCases

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

                ScrollView {
                    VStack(spacing: 16) {
                        // 통계
                        VStack(spacing: 16) {
                            CardSummaryView(mealVM: mealVM)
                        }
                        .modifier(CardStyleModifier())
                        .padding(.horizontal, 20)

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
                                            let type = Mealtypes[row * 2 + col]
                                            let kcal = mealVM.typeCalories(
                                                records,
                                                date: mealVM.selectedDate,
                                                type: type
                                            )
                                            CardMealButtonView(mealtype: Mealtypes[row * 2 + col], typeCalories: kcal)
                                        }
                                    }
                                }
                            }
                        }
                        .modifier(CardStyleModifier())
                        .padding(.horizontal, 20)

                        // 메모
                        VStack(spacing: 16) {
                            CardMemoView(mealVM: mealVM, type: .meal)
                                .buttonStyle(.plain)
                        }
                        .modifier(CardStyleModifier())
                        .padding(.horizontal, 20)
                    }
                    .padding(.top)

                    .frame(maxWidth: .infinity)
                }
                .scrollIndicators(.hidden)
                .background(colorScheme == .dark ? .black : Color(.systemGray6))
            }
        }
    }
}

#Preview {
    DailyMealView(mealVM: DailyMealViewModel())
}
