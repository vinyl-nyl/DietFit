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
    var value: Int
    var type: GoalType
    var id = UUID()

    init(value: Int, type: GoalType) {
        self.value = value
        self.type = type
    }
}
