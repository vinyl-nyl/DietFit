//
//  Date+Extension.swift
//  DietFit
//
//  Created by 박동언 on 5/15/25.
//

import Foundation

// 정규화를 위한 간편화
extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

// 포맷 원하는 형식으로 받아서 ko-KR로 변환
// M.d E, M월 일, dd
extension Date {
    func dateFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko-KR")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
