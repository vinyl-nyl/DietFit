//
//  DailyMealView.swift
//  DietFit
//
//  Created by 박동언 on 5/12/25.
//

import SwiftUI

struct DailyMealView: View {
    let mealTypes = ["아침", "점심", "저녁", "간식"]

    var body: some View {
        // 상단 바 - 날짜 선택, 유저 아이콘
        VStack(spacing: 0) {

            VStack {
                HStack {
                    Button {

                    } label: {
                        Text("날짜")
                        Image(systemName: "star")
                    }

                    Spacer()

                    Button {

                    } label: {
                        // Image
                        Image(systemName: "star")
                    }

                }
                .buttonStyle(.plain)

                // 캘린더 스크롤 뷰
                ScrollCalendarView()
            }
//            .background(Color.buttonPrimary)
            
            GeometryReader { geo in
                ScrollView {
                    VStack(spacing: 20) {

                        // 하루통계
                        VStack {
                            HStack {
                                Text("하루 통계")
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .frame(width: geo.size.width * 0.9, height: 250)
                        .modifier(CardStyleModifier())

                        // 식단
                        VStack {
                            Grid(horizontalSpacing: 40, verticalSpacing: 10) {
//                                ForEach(mealTypes, id: \.self) { row in
//                                    ForEach(0..<2) { column i in
//                                    }
//                                }

                                GridRow {
                                    MealButtonView(title: mealTypes[2], size: geo.size.width * 0.25)
                                    MealButtonView(title: mealTypes[2], size: geo.size.width * 0.25)

                             }

                                GridRow {
                                    MealButtonView(title: mealTypes[2], size: geo.size.width * 0.25)
                                    MealButtonView(title: mealTypes[2], size: geo.size.width * 0.25)
                                }
                            }
                        }
                        .frame(width: geo.size.width * 0.9, height: 300)
                        .modifier(CardStyleModifier())

                        // 메모
                        VStack {
                            HStack {
                                Text("메모")
                            }
                        }
                        .frame(width: geo.size.width * 0.9, height: 250)
                        .modifier(CardStyleModifier())
                    }
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    DailyMealView()
}


