//
//  FitnessSummaryView.swift
//  DietFit
//
//  Created by Heejung Yang on 5/16/25.
//

import SwiftUI
import SwiftData

struct FitnessSummaryView: View {
    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var vm: DailyMealViewModel
    @Query private var fitnessRecords: [FitnessModel]

    var todayFitness: [FitnessModel] {
        return fitnessRecords.filter { $0.insertDate == vm.selectedDate }
    }

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
                    .trim(from: 0, to: 0.2)
                    .stroke(Color.buttonPrimary, style: .init(lineWidth: 40, lineCap: .round))
                    .frame(width: 200, height: 200)
                    .offset(y: 50)
                //                                        .animation(.easeInOut, value: percentage)
                let dayTotal = todayFitness.reduce(0) { $0 + $1.calories } 
                VStack {
                    Text("\(dayTotal)")
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.buttonPrimary)
                    Text("/ 2000 Kcal")
                        .font(.title3)
                }
                .offset(y: 25)
            }
        }
    }

//    private var dayTotal: Int {
//        // 해당 날짜에 MealRecord 가져오기
//        guard let todayRecord = records.first(where: { $0.date == mealVM.selectedDate }) else {
//            return 0
//        }
//        //
//        return todayRecord .meals.reduce(0) { $0 + $1.totalCalories }
//    }
}

#Preview {
//    FitnessSummaryView()
}
