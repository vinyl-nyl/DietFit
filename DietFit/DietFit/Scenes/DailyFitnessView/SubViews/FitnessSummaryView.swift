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

        if todayFitness.isEmpty {
            Text("아직 운동을 하지 않았어요.")
                .font(.headline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 40)
        } else {

            VStack {
                Image("gym")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                ZStack {


                    let durationTotal = todayFitness.reduce(0) { $0 + $1.duration }
                    HStack {
                        Text("\(durationTotal)분")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.black)
                        Text("운동으로")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
    //                .offset(y: 50)

                    let dayTotal = todayFitness.reduce(0) { $0 + $1.calories }
                    HStack {
                        Text("\(dayTotal)kcal")
                            .font(.title)
                            .bold()
                            .foregroundStyle(Color.buttonPrimary)
                        Text("태웠어요.")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }

                    .offset(y: 25)
                }
                .padding(.bottom, 20)
            }
            .frame(width: 200, height: 200)
        }

    }

}

#Preview {
//    FitnessSummaryView()
}
