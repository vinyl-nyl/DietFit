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
                ScrollView {
                    VStack(spacing: 16) {
                        // 통계
                        VStack(spacing: 16) {
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
                                        .stroke(colorScheme == .dark ? Color(.systemGray4)  : Color(.systemGray6), style: .init(lineWidth: 40, lineCap: .round))
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

                                    VStack {
                                        Text("500")
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
                        .frame(width: 360, height: 280)
                        .modifier(CardStyleModifier())

                        // 식단
                        VStack(spacing: 16) {
                            Text("오늘의 식단")
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 40)

                            Grid(horizontalSpacing: 20, verticalSpacing: 20) {
                                ForEach(0..<2) { row in
                                    GridRow {
                                        ForEach(0..<2) { col in
                                            CardMealButtonView(type: mealTypes[row * 2 + col])

                                        }
                                    }
                                }
                            }
                        }
                        .frame(width: 360, height: 360)
                        .modifier(CardStyleModifier())

                        // 메모
                        CardMemoView()
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




