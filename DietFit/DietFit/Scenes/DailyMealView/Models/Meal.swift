//
//  Meal.swift
//  DietFit
//
//  Created by 박동언 on 5/15/25.
//

import Foundation
import SwiftData

@Model
final class Meal {
    var type: MealType
    var foods: [Food]

    init(type: MealType, foods: [Food] = []) {
        self.type = type
        self.foods = foods
    }
}
