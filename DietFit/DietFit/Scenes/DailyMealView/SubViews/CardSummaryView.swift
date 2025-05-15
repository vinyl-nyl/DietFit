//
//  CardSummaryView.swift
//  DietFit
//
//  Created by 박동언 on 5/14/25.
//

import SwiftUI
import SwiftData

struct CardSummaryView: View {
    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var mealVM: DailyMealViewModel
    @Query var records: [MealRecord]
    @Query var goal: [Goal]

    let today = Date().startOfDay

    var body: some View {
        Text("오늘의 성과")
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 40)
        
        VStack {
            ZStack {
                Circle()
                    .inset(by: -30)
                    .rotation(.degrees(-180))
                    .trim(from: 0, to: 0.5)
                    .stroke(colorScheme == .dark ? Color(.systemGray4)  : Color(.systemGray6),
                            style: .init(lineWidth: 40, lineCap: .round))
                    .frame(width: 200, height: 200)
                    .offset(y: 50)
                
                Circle()
                    .inset(by: -30)
                    .rotation(.degrees(-180))
                    .trim(from: 0, to: mealRatio)
                    .stroke(Color.buttonPrimary, style: .init(lineWidth: 40, lineCap: .round))
                    .frame(width: 200, height: 200)
                    .offset(y: 50)

                VStack {
                    Text("\(dayTotal)")
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.buttonPrimary)
                    Text("/ \(mealGoal) Kcal")
                        .font(.title3)
                }
                .offset(y: 25)
            }
        }
    }

    private var mealGoal: Int {
        goal.last(where: { $0.type == .meal })?.value ?? 2500
    }

    private var mealRatio: CGFloat {
        guard mealGoal > 0 else {
            return 0
        }
        return min(0.5, CGFloat(dayTotal) / CGFloat(mealGoal) / 2)
    }

    private var dayTotal: Int {
        // 해당 날짜에 MealRecord 가져오기
        guard let todayRecord = records.first(where: { $0.date == mealVM.selectedDate }) else {
            return 0
        }
        // 모든 데이터 더하기
        return todayRecord.meals.reduce(0) { $0 + $1.totalCalories }
    }
}

#Preview {
    CardSummaryView(mealVM: DailyMealViewModel())
}
