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

    @State private var bmiEntries: [BMIEntry] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TodayGoalsView()

                    Divider()
                        .padding(.top, 20)
                        .padding(.bottom, 20)

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
                                Text(todayBmi)
                                    .font(Double(todayBmi) != nil ? .largeTitle : .title3)
                                    .bold()
                                    .foregroundStyle(.buttonPrimary)
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
                                HStack {
                                    Button("취소") {
                                        showWeightInput = false
                                    }

                                    .tint(.red)

                                    Spacer()

                                    Button("확인") {
                                        if Double(inputWeight) != nil {
                                            showWeightInput = false
                                        }
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.green)
                                }
                                .padding(.horizontal)
                                .padding(.top)

                                Spacer().frame(height: 20)

                                // 본문 영역
                                VStack(spacing: 20) {
                                    Text("오늘의 몸무게를 입력해주세요")
                                        .font(.headline)

                                    TextField("몸무게 (kg)", text: $inputWeight)
                                        .keyboardType(.decimalPad)
                                        .textFieldStyle(.roundedBorder)
                                        .padding(.horizontal)
                                }

                                Spacer()
                            }
                            .presentationDetents([.medium])
                        }

                        Spacer()
                    }
                    .padding(.bottom, 20)

                    VStack {
                        HStack {
                            Text("BMI 히스토리")

                            Spacer()
                        }
                        .fontWeight(.semibold)

                        Chart {
                            ForEach(bmiEntries) { entry in
                                LineMark(
                                    x: .value("Date", entry.date),
                                    y: .value("BMI", entry.BMI)
                                )
                                .foregroundStyle(.red)
                            }
                        }
                        .frame(height: 200)
                    }

                    Divider()
                        .padding(.top, 20)
                        .padding(.bottom, 20)

                    VStack {
                        HStack  {
                            Text("몸무게 히스토리")

                            Spacer()
                        }
                        .fontWeight(.semibold)

                        Chart {
                            ForEach(bmiEntries) { entry in
                                LineMark(
                                    x: .value("Date", entry.date),
                                    y: .value("Weight", entry.weight)
                                )
                                .foregroundStyle(.buttonPrimary)
                            }
                        }
                        .frame(height: 200)
                    }
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            .navigationTitle("요약")
        }
        .onAppear {
            bmiEntries = loadBMIData()

            if let todayEntry = bmiEntries.first(where: { Calendar.current.isDate($0.date, inSameDayAs: Date()) }) {
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
