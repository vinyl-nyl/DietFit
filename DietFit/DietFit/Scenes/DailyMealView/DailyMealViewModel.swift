//
//  DailyMealViewModel.swift
//  DietFit
//
//  Created by 박동언 on 5/15/25.
//

import Foundation

class DailyMealViewModel: ObservableObject {
    @Published var selectedDate: Date = Date().startOfDay
    @Published var days: [Date] = []

    init() {
        days = generateDays(selectedDate)
    }

    // selectedDate를 바꾸고 days도 갱신
     func updateSelectedDate(to newDate: Date) {
         selectedDate = newDate
         days = generateDays(newDate)
     }

    // 스크롤 캘린더 -60...60 범위의 날짜 배열
    func generateDays(_ selectedDate: Date) -> [Date] {
        let calendar = Calendar.current
        let range = -60...60

        return range.compactMap {
            calendar.date(byAdding: .day, value: $0, to: selectedDate)
        }
    }
}
