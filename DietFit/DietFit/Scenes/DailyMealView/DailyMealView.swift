//
//  DailyMealView.swift
//  DietFit
//
//  Created by 박동언 on 5/12/25.
//

import SwiftUI

struct DailyMealView: View {
    @Environment(\.colorScheme) private var colorScheme

    @State private var presentCalendar = false
    @State private var selectDate = Date()

    @State var isOn: Bool = false

    let mealTypes = MealType.allCases

    var body: some View {
        VStack(spacing: 0) {
            // 상단 바 - 날짜 선택, 유저 아이콘
            VStack(spacing: 0) {
                HStack {
                    Button {
                        presentCalendar = true
                    } label: {
                        Text(dateFormat(selectDate))
                            .font(.title3)
                            .bold()
                        Image(systemName: "arrowtriangle.down.fill")
                    }
                    .sheet(isPresented: $presentCalendar) {
                        VStack {
                            DatePicker("Select a date", selection: $selectDate, displayedComponents: [.date])
                                .datePickerStyle(.graphical)
                                .tint(Color.buttonPrimary)
                                .padding()
                                .onChange(of: selectDate) {
                                    presentCalendar = false
                                }
                        }
                        .presentationDetents([.fraction(0.6)])
                        .presentationDragIndicator(.visible)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal)

                }
                .frame(maxWidth: .infinity, alignment: .leading)

                ScrollCalendarView(selectDate: $selectDate)
            }

            GeometryReader { geo in
                let width = geo.size.width

                ScrollView {
                    VStack(spacing: 16) {
                        // 하루통계
                        VStack(spacing: 16) {
                            Text("오늘의 성과")
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, width * 0.1)

                            ZStack {
                                Circle()
                                //                                        .fill(style: Color.white)
                                //                                        .inset(by: 0)
                                    .rotation(.degrees(-180))
                                    .trim(from: 0, to: 0.5)
                                    .stroke(colorScheme == .dark ? Color(.systemGray4)  : Color(.systemGray6), style: .init(lineWidth: 50, lineCap: .round))
                                    .frame(width: width * 0.6, height: width * 0.6)

                                Circle()
//                                    .inset(by: 25)
                                    .rotation(.degrees(-180))
                                    .trim(from: 0, to: 0.2)
                                    .stroke(Color.buttonPrimary, style: .init(lineWidth: 50, lineCap: .round))
                                    .frame(width: width * 0.76, height: width * 0.6)
//                                    .animation(.easeInOut, value: percentage)


                                Text("달성률%")
                            }
//                            .background(.black)

                            HStack {
                                Text("0 Kcal 소모")
                                Text("2000 Kcal 더 먹자")

                            }

                        }
                        .frame(width: width * 0.9, height: width * 0.9)
                        .modifier(CardStyleModifier())

                        // 식단
                        VStack(spacing: 16) {
                            Text("오늘의 식단")
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, width * 0.1)

                            Grid(horizontalSpacing: width * 0.05, verticalSpacing: width * 0.05) {
                                ForEach(0..<2) { row in
                                    GridRow {
                                        ForEach(0..<2) { col in
                                            CardMealButtonView(type: mealTypes[row * 2 + col], width: width)

                                        }
                                    }
                                }
                            }
                        }
                        .frame(width: width * 0.9, height: width * 0.9)
                        .modifier(CardStyleModifier())

                        // 메모
                        CardMemoView(width: width)
                    }
                    .padding(.top)
                    
                    .frame(maxWidth: .infinity)
                }
                .background(colorScheme == .dark ? .black : Color(.systemGray6))
            }
        }
        .scrollIndicators(.hidden)
    }
}

func dateFormat(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "M.d E"
    return formatter.string(from: date)
}

#Preview {
    DailyMealView()
}




