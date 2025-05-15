//
//  TodayGoalsView.swift
//  DietFit
//
//  Created by junil on 5/13/25.
//
// HomeView: 하루 목표 달성 View

import SwiftUI
import SwiftData

struct TodayGoalsView: View {
    @EnvironmentObject var tabManager: TabSelectionManager

    @Query var goal: [Goal]
    @ObservedObject var mealVM: DailyMealViewModel
    @Query var records: [MealRecord]

    var mealGoal: Int {
        goal.last(where: { $0.type == .meal })?.value ?? 2500
    }

    var fitnessGoal: Int {
        goal.last(where: { $0.type == .fitness })?.value ?? 2500
    }

    private var dayTotal: Int {
        // 해당 날짜에 MealRecord 가져오기
        guard let todayRecord = records.first(where: { $0.date == mealVM.selectedDate }) else {
            return 0
        }
        //
        return todayRecord.meals.reduce(0) { $0 + $1.totalCalories }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color(.systemGray6))

                VStack(spacing: 0) {
                    HStack {
                        Text("하루 목표 달성")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)

                        Spacer()
                    }

                    Rectangle()
                        .frame(height: 0.2)
                        .foregroundStyle(.primary)
                        .opacity(0.5)

                    HStack(spacing: 60) {
                        Button {
                            tabManager.selectedTabIndex = 2
                        } label: {
                            VStack(spacing: 10) {
                                CircularProgressView(iconName: "dumbbell.fill", goalKcal: fitnessGoal, ongoingKcal: 0)
                            }
                        }

                        Button {
                            tabManager.selectedTabIndex = 1
                        } label: {
                            VStack(spacing: 10) {
                                CircularProgressView(iconName: "fork.knife", goalKcal: mealGoal, ongoingKcal: dayTotal)
                            }
                        }
                    }
                    .foregroundStyle(.placeholder)
                    .padding(.vertical, 20)
                }
                .frame(maxWidth: .infinity)
            }

        }
    }
}

class TabSelectionManager: ObservableObject {
    @Published var selectedTabIndex: Int = 0
}

#Preview {
    TodayGoalsView(mealVM: DailyMealViewModel())
}
