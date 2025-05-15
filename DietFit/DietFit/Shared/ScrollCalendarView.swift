//
//  ScrollCalendarView.swift
//  MySwiftUICatalog
//
//  Created by 박동언 on 5/12/25.
//

import SwiftUI

struct ScrollCalendarView: View {
    @Environment(\.colorScheme) private var colorScheme

    @State private var scrollTargetId: Date?

    @ObservedObject var mealVM: DailyMealViewModel

     private let calendar = Calendar.current
     private let today = Date().startOfDay // 시분초 정규화

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(mealVM.days, id: \.self) { date in
                        let isSelected = calendar.isDate(date, inSameDayAs: mealVM.selectedDate)
                        let weekdayString = date.dateFormat("E")
                        let dayString = date.dateFormat("d")
                        VStack {
                            Group {
                                Text(weekdayString)
                                    .foregroundStyle(.buttonPrimary)
                                Button { // 선택한 날짜 가운데 정렬
                                    withAnimation {
//                                        mealVM.updateDays(from: date)
                                        mealVM.selectedDate = date
                                        scrollTargetId = date
                                    }
                                } label: {
                                    Text(dayString)
                                        .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                                .frame(width: 36, height: 36)
                                .foregroundStyle(isSelected ? .white : .buttonPrimary)
                                .background(isSelected ? .buttonPrimary : .clear)
                                .clipShape(Circle())
                                .id(date)
                            }
                            .font(.callout)
                            .bold()
                        }
                        .padding(.horizontal, 4)
                    }
                }
                .padding()
                .background(colorScheme == .dark ? .black : .white)
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .onAppear { // 뷰가 보일 때 오늘 날짜을 가운데 선택, 정렬
                withAnimation {
                    if mealVM.selectedDate == today {
                        // 처음 앱 진입 시에만 오늘 날짜로 설정
                        mealVM.selectedDate = today
    //                    mealVM.updateDays(from: today)
                        scrollTargetId = today
                    }
                }
            }
            .onChange(of: mealVM.selectedDate) {
                withAnimation {
                    scrollTargetId = mealVM.selectedDate
                }
            }
            .scrollPosition(id: $scrollTargetId, anchor: .center)
        }
    }
}

#Preview {
    ScrollCalendarView(mealVM: DailyMealViewModel())
}
