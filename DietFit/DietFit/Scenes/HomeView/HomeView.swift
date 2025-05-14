//
//  HomeView.swift
//  DietFit
//
//  Created by junil on 5/12/25.
//

import Charts
import SwiftUI

struct HomeView: View {
    @State var showBmiSheet: Bool = false
    @State private var showWeightInput = false

    @State private var inputWeight: String = ""
    @State var todayBmi: String = ""

    @State private var selectedRange: TimeRange = .week

    @State private var bmiEntries: [BMIEntry] = []

    enum TimeRange: String, CaseIterable, Identifiable {
        case week = "주"
        case month = "월"
        case year = "년"

        var id: String { self.rawValue }
    }

    var filteredEntries: [BMIEntry] {
        let calendar = Calendar.current
        let now = Date()

        switch selectedRange {
        case .week:
            guard let startDate = calendar.date(byAdding: .day, value: -6, to: now) else { return bmiEntries }
            return bmiEntries.filter { $0.date >= startDate }

        case .month:
            guard let startDate = calendar.date(byAdding: .month, value: -1, to: now) else { return bmiEntries }
            return bmiEntries.filter { $0.date >= startDate }

        case .year:
            guard let startDate = calendar.date(byAdding: .year, value: -1, to: now) else { return bmiEntries }
            return bmiEntries.filter { $0.date >= startDate }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TodayGoalsView()
                        .padding(.bottom, 40)

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Today's BMI")
                                .fontWeight(.semibold)

                            Button {
                                if Double(todayBmi) == nil {
                                    showWeightInput = true
                                } else {
                                    showBmiSheet = true
                                }
                            } label: {
                                if let bmi = Double(todayBmi) {
                                    Text(todayBmi)
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundStyle(BMITextColor(bmiData: bmi))
                                } else {
                                    Text(todayBmi)
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                        .sheet(isPresented: $showBmiSheet) {
                            HStack {
                                BMIPresentationView()
                            }
                            .padding(.horizontal, 20)
                            .presentationDetents([.medium])
                        }
                        .sheet(isPresented: $showWeightInput) {
                            VStack(alignment: .leading) {
                                InputWeightPresentationView(showWeightInput: $showWeightInput, inputWeight: $inputWeight)

                                Spacer()
                            }
                            .presentationDetents([.medium])
                        }

                        Spacer()
                    }
                    .padding(.bottom, 40)

                    ChartView()
                }
            }
            .navigationTitle("요약")
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .onAppear {
            bmiEntries = loadBMIData()

            if let todayEntry = filteredEntries.first(where: { Calendar.current.isDate($0.date, inSameDayAs: Date()) }) {
                todayBmi = String(format: "%.1f", todayEntry.BMI)
            } else {
                todayBmi = "몸무게를 입력해주세요"
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(\.locale, Locale(identifier: "ko_kr"))
}
