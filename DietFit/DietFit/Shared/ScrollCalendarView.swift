//
//  ScrollCalendarView.swift
//  MySwiftUICatalog
//
//  Created by 박동언 on 5/12/25.
//

import SwiftUI

struct ScrollCalendarView: View {
    private let calendar = Calendar.current
    private let today = Calendar.current.startOfDay(for: Date())

    private var daysOfMonth = generateDaysOfMonth()

    @State private var selectDate: Date = Date()
    @State private var scrollTargetId: Date?

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(daysOfMonth.indices, id: \.self) { index in
                        let date = daysOfMonth[index]
                        let isSelected = calendar.isDate(date, inSameDayAs: selectDate)
                        let dateInfo = generateDateInfo(date)

                        VStack {
                            Group {
                                Text(dateInfo.weekday)
                                    .foregroundStyle(Color.buttonPrimary)
                                Button {
                                    withAnimation {
                                        selectDate = date
                                        scrollTargetId = date
                                    }
                                } label: {
                                    Text(dateInfo.day)
                                }
                                .buttonStyle(.plain)
                                .padding(8)
                                .foregroundStyle(isSelected ? Color.buttonPrimary : .white)
                                .background(isSelected ? .white : .buttonPrimary)
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
                .scrollTargetLayout()
            }
            //            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .onAppear {
                withAnimation {
//                    proxy.scrollTo(today)
                    selectDate = today
                    scrollTargetId = today
                }
            }
            .scrollPosition(id: $scrollTargetId, anchor: .center)
        }

    }

    private func generateDateInfo(_ date: Date) -> (day: String, weekday: String){
        let day = String(calendar.component(.day, from: date))

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "E"

        let weekday = dateFormatter.string(from: date)

        return (day, weekday)
    }

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
    ScrollCalendarView()
}
