//
//  HomeView.swift
//  DietFit
//
//  Created by junil on 5/12/25.
//

import Charts
import SwiftUI

struct HomeView: View {
    @State var showAlert: Bool = false
    @State var nowDate: Date = Date.now
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
                                showAlert = true
                            } label: {
                                Text("23")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundStyle(.green)
                            }
                        }
                        .sheet(isPresented: $showAlert) {
                            HStack {
                                BMIPresentationView()
                            }
                            .padding(.horizontal, 20)
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
                                .foregroundStyle(.green)
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
        }
    }
    // TODO: BMI = weight / (height(M)*height(M)) 함수 구현하기
    // TODO: BMI 비만지수 분류하기
    /*
     BMI      수치분류
     ~ 18.5      저체중
     18.5 ~ 24.9  정상 체중
     25.0 ~ 29.9   과체중
     30.0 이상     비만
     */
}

func BMIColor(circleColor: Color, text: String) -> some View {
    HStack {
        Circle()
            .frame(width: 10, height: 10)
            .foregroundStyle(circleColor)
        Text(text)
            .font(.callout)
            .foregroundStyle(.secondary)
    }
}

func date(year: Int, month: Int, day: Int = 1) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}

#Preview {
    HomeView()
        .environment(\.locale, Locale(identifier: "ko_kr"))
}
