//
//  BMIEntry.swift
//  DietFit
//
//  Created by junil on 5/13/25.
//

import Foundation
import SwiftUI

struct BMIEntry: Identifiable {
    let id = UUID()
    let date: Date
    let weight: Double
    let BMI: Double
}

func loadBMIData() -> [BMIEntry] {
    var result: [BMIEntry] = []
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    guard let filePath = Bundle.main.path(forResource: "daily_bmi_weight_data", ofType: "csv") else {
        print("CSV 파일을 찾을 수 없습니다.")
        return []
    }

    do {
        let data = try String(contentsOfFile: filePath, encoding: .utf8)
        let lines = data.components(separatedBy: .newlines)

        for line in lines.dropFirst() where !line.isEmpty {
            let fields = line.components(separatedBy: ",")
            if fields.count == 3,
               let date = dateFormatter.date(from: fields[0]),
               let weight = Double(fields[1]),
               let bmi = Double(fields[2]) {
                result.append(BMIEntry(date: date, weight: weight, BMI: bmi))
            }
        }
    } catch {
        print("CSV 파일을 읽는 중 오류 발생: \(error)")
    }

    return result
}
