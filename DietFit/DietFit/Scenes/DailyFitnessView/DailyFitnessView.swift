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

    @ObservedObject var mealVM: DailyMealViewModel

    @State private var presentCalendar = false
    @State var presentAddFitness: Bool = false

    init(mealVM: DailyMealViewModel) {
        self.mealVM = mealVM
    }

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
                        FitnessSummaryView(vm: mealVM)
                    }
                    .modifier(CardStyleModifier())
                    .padding(.horizontal, 20)
                    .padding(.top, 16)


                    VStack(spacing: 16) {
                        FitnessListView(vm: mealVM)
                    }
                    .modifier(CardStyleModifier())
                    .padding(.horizontal, 20)
                    .padding(.top, 6)

                        // 메모
                    VStack(spacing: 16) {
                        CardMemoView(mealVM: mealVM, type: .fitness)
                            .buttonStyle(.plain)
                    }
                    .modifier(CardStyleModifier())
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
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
