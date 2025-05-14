//
//  ScrollCalendarView.swift
//  MySwiftUICatalog
//
//  Created by 박동언 on 5/12/25.
//

import SwiftUI

struct ScrollCalendarView: View {
    @Environment(\.colorScheme) private var colorScheme

    @Binding var selectedDate: Date

     private let calendar = Calendar.current
     private let today = Date()

    // ?? private를 쓰면 바인딩할때 에러
     var daysOfMonth = generateDaysOfMonth()

    @State private var scrollTargetId: Date?

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(daysOfMonth, id: \.self) { date in
                        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
                        let dateInfo = generateDateInfo(date)

                        VStack {
                            Group {
                                Text(dateInfo.weekday)
                                    .foregroundStyle(.buttonPrimary)
                                Button { // 선택한 날짜 가운데 정렬
                                    withAnimation {
                                        selectedDate = date
                                        scrollTargetId = date
                                    }
                                } label: {
                                    Text(dateInfo.day)
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
//            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .onAppear { // 뷰가 보일 때 오늘을 가운데 선택, 정렬
                withAnimation {
//                    proxy.scrollTo(today)
                    let startOfDay = calendar.startOfDay(for: today)
                    selectedDate = startOfDay
                    scrollTargetId = startOfDay
                }
            }
            .onChange(of: selectedDate) {
                withAnimation {
                    scrollTargetId = selectedDate
                }
            }
            .scrollPosition(id: $scrollTargetId, anchor: .center)
        }

    }

    // 날짜와 요일 튜플로 반환
    private func generateDateInfo(_ date: Date) -> (day: String, weekday: String){
        let day = String(calendar.component(.day, from: date))

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "E"

        let weekday = dateFormatter.string(from: date)

        return (day, weekday)
    }

    // 이번 달 날짜를 배열로 반환
    private static func generateDaysOfMonth() -> [Date] {
        let today = Date()
        let calendar = Calendar.current

        guard let dateOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: today)) else {
            return []
        }

        let startOfMonth = calendar.startOfDay(for: dateOfMonth)

        guard let rangeOfMonth = calendar.range(of: .day, in: .month, for: today) else {
            return []
        }
        
        return rangeOfMonth.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }

}

#Preview {
    ScrollCalendarView(selectedDate: .constant(Date()))
}
