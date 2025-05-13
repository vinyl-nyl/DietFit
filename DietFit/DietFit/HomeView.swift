//
//  HomeView.swift
//  DietFit
//
//  Created by junil on 5/12/25.
//

import Charts
import SwiftUI

struct HomeView: View {
    @State private var name: String = "준일"
    @State var showAlert: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Today's BMI")
                                .fontWeight(.semibold)

                            Button {
                                showAlert = true
                            } label: {
                                Text("21")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundStyle(.green)
                            }
                        }
                        .sheet(isPresented: $showAlert) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("BMI 수치 기준")
                                        .font(.headline)
                                    BMIColor(circleColor: .red, text: "비만")
                                    BMIColor(circleColor: .yellow, text: "과체중")
                                    BMIColor(circleColor: .green, text: "정상")
                                    BMIColor(circleColor: .secondary, text: "저체중")
                                }
                                .padding()

                                Spacer()

                                VStack(alignment: .trailing, spacing: 8) {
                                    Text("BMI 범위")
                                        .font(.headline)

                                    VStack(alignment: .trailing, spacing: 8) {
                                        Text("30.0 ~")
                                        Text("25.0 ~ 29.9")
                                        Text("18.5 ~ 24.9")
                                        Text("~ 18.5")
                                    }
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                                }
                                .padding()
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
                            ForEach(data, id: \.month) {
                                LineMark(
                                    x: .value("Month", $0.month, unit: .month),
                                    y: .value("BMI", $0.BMI)
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
                            ForEach(data, id: \.month) {
                                LineMark(
                                    x: .value("Month", $0.month, unit: .month),
                                    y: .value("weight", $0.weight)
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
            .navigationTitle("다이어핏")
        }
    }



    // TODO: BMI = weight / (height(M)*height(M)) 함수 구현하기
    // TODO: BMI 수치로 비만지수 분류하기
    /*
     BMI      수치분류
     ~ 18.5      저체중
     18.5 ~ 24.9  정상 체중
     25.0 ~ 29.9   과체중
     30.0 이상     비만
     */

    let data = [
        (month: date(year: 2021, month: 7), weight: 92, BMI: 32),
        (month: date(year: 2021, month: 8), weight: 90, BMI: 31),
        (month: date(year: 2021, month: 9), weight: 89, BMI: 31),
        (month: date(year: 2021, month: 10), weight: 87, BMI: 30),
        (month: date(year: 2021, month: 11), weight: 88, BMI: 30),
        (month: date(year: 2021, month: 12), weight: 87, BMI: 30),
        (month: date(year: 2022, month: 1), weight: 85, BMI: 28),
        (month: date(year: 2022, month: 2), weight: 84, BMI: 28),
        (month: date(year: 2022, month: 3), weight: 82, BMI: 26),
        (month: date(year: 2022, month: 4), weight: 78, BMI: 23),
        (month: date(year: 2022, month: 5), weight: 77, BMI: 22),
        (month: date(year: 2022, month: 6), weight: 75, BMI: 21)
    ]
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
