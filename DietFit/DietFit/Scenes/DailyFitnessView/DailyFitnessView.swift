//
//  DailyFitnessView.swift
//  Dietfit
//
//  Created by Heejung Yang on 5/13/25.
//

import SwiftUI
import SwiftData

struct DailyFitnessView: View {

    @Environment(\.colorScheme) private var colorScheme

    @Query(sort: [SortDescriptor(\FitnessModel.insertDate, order: .reverse)])
    var datas: [FitnessModel]

    @ObservedObject var mealVM: DailyMealViewModel

    @State private var presentCalendar = false
    @State var presentAddFitness: Bool = false
    @State private var selectDate = Date()

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
                        CardSummaryView(mealVM: mealVM)
                    }
                    .modifier(CardStyleModifier())
                    .padding(.horizontal, 20)
                    .padding(.top, 16)


                    VStack(spacing: 16) {
                        if datas.isEmpty {
                            Text("운동 기록하기")
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 40)

                            NavigationLink {
                                CategoryView()
                            } label: {
                                VStack(alignment: .center, spacing: 16) {
                                    HStack(spacing: 25) {
                                        Image(systemName: "plus")
                                    }
                                    .font(.title)
                                    .imageScale(.large)
                                }
                                .dynamicTypeSize(.large)
                            }
                            .modifier(CardStyleModifier())
                            .padding(.horizontal, 16)

                        } else {

                            VStack(spacing: 0) {
                                HStack {
                                    Text("오늘의 운동")
                                        .font(.title3)
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 40)

                                    NavigationLink {
                                        CategoryView()
                                    } label: {
                                        VStack(alignment: .center, spacing: 16) {
                                            Text("추가")
                                                .fontWeight(.light)
                                        }
                                        .dynamicTypeSize(.large)
                                    }
                                }

                                Grid(horizontalSpacing: 20, verticalSpacing: 20) {


                                    ForEach(datas) { data in
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
                            .modifier(CardStyleModifier())
                            .padding(16)
                            .background(Color(.systemGray6))
                        }
                        // 메모
                        VStack(spacing: 16) {
                            CardMemoView(mealVM: mealVM)
                                .buttonStyle(.plain)
                        }
                        .modifier(CardStyleModifier())
                        .padding(.horizontal, 20)

                    }
                    .frame(maxWidth: .infinity)
                }
                .scrollIndicators(.hidden)
                .background(colorScheme == .dark ? .black : Color(.systemGray6))
            }
        }
    }

}

#Preview {
//    DailyFitnessView()
}
