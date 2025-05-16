//
//  DailyMealViewModel.swift
//  DietFit
//
//  Created by 박동언 on 5/15/25.
//

import Foundation
import SwiftData

class DailyMealViewModel: ObservableObject {
    @Published var selectedDate: Date = Date().startOfDay
    @Published var days: [Date] = []    

    init() {
        days = generateDays(from: selectedDate)
    }

    
    // days 재생성
    // selectedDate도 갱신
     func updateDays(from newDate: Date) {
         // 1. 새로운 days 배열 생성
         days = generateDays(from: newDate)

         // 2. selectedDate도 갱신
         selectedDate = newDate
     }

    // 스크롤 캘린더 원하는 범위의 날짜 배열
    func generateDays(from selectedDate: Date) -> [Date] {
        let calendar = Calendar.current
        let range = -60...60

        return range.compactMap {
            calendar.date(byAdding: .day, value: $0, to: selectedDate)
        }
    }

    // 끼니별 총 칼로리 계산
    func typeCalories(_ records: [MealRecord], date: Date, type: MealType) -> Int {
        // 해당 날짜에 MealRecord 가져오기
        guard let dayRecord = records.first(where: { $0.date == date }) else {
            return 0
        }

        // 해당 날짜에 MealRecord에서 끼니 가져오기
        guard let dayMeal = dayRecord.meals.first(where: { $0.type == type }) else {
            return 0
        }
        
        return dayMeal.totalCalories
    }

}
