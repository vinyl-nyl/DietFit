//
//  Untitled.swift
//  DietFit
//
//  Created by 박동언 on 5/16/25.
//

import Foundation
import SwiftData

@Model
final class Goal {
    var mealGoals: Int
    var fitnessGoals: Int
	var id = UUID()

    init(mealGoals: Int = 0, fitnessGoals: Int = 0) {
        self.mealGoals = mealGoals
        self.fitnessGoals = fitnessGoals
    }
}
