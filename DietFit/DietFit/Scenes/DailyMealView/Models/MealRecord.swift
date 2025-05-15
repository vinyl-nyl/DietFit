//
//  MealRecord.swift
//  DietFit
//
//  Created by 박동언 on 5/15/25.
//

import Foundation
import SwiftData

@Model
final class MealRecord {
    var date: Date
    var meals: [Meal]
    var memo: String?

    init(date: Date = Date().startOfDay, meals: [Meal] = [], memo: String? = nil) {
        self.date = date
        self.meals = meals
        self.memo = memo
    }
}
