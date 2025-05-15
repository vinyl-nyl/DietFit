//
//  FitnessListView.swift
//  DietFit
//
//  Created by Heejung Yang on 5/16/25.
//

import SwiftUI
import SwiftData

struct FitnessListView: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var vm: DailyMealViewModel

    @Query private var fitnessRecords: [FitnessModel]

    var todayFitness: [FitnessModel] {
        return fitnessRecords.filter { $0.insertDate == vm.selectedDate }
    }

    var body: some View {
        if todayFitness.isEmpty {
            VStack {
                Text("운동 기록하기")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 40)

                NavigationLink {
                    CategoryView(selectedDate: vm.selectedDate)
                } label: {
                    VStack(alignment: .center, spacing: 16) {
                        HStack(spacing: 25) {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .font(.title)
                        .imageScale(.large)
                    }
                    .dynamicTypeSize(.large)
                }
            }

        } else {
            VStack(spacing: 0) {
                HStack {
                    Text("오늘의 운동")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 40)

                    NavigationLink {
                        CategoryView(selectedDate: vm.selectedDate)
                    } label: {
                        VStack(alignment: .center, spacing: 16) {
                            Text("추가")
                                .fontWeight(.light)
                        }
                        .dynamicTypeSize(.large)
                    }
                }

                Grid(horizontalSpacing: 20, verticalSpacing: 20) {


                    ForEach(todayFitness) { data in
                        // Disclosure Indicator
                        GridRow {
                            Image(systemName: "figure.run.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)

                            VStack(alignment: .leading) {
                                Text(data.exercise)

                                Text("\(data.calories)kcal" )
                                    .bold()

                                Text("\(data.duration)분 | \(data.intensity)")
                                .fontWeight(.light)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: 90)

                        }

                    }
                }
                .padding(.vertical, 16)

            }
        }


    }
}

#Preview {
//    FitnessListView()
}
