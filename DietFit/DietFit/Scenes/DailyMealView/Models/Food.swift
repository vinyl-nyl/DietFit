//
//  Food.swift
//  DietFit
//
//  Created by 박동언 on 5/15/25.
//

import Foundation
import SwiftData

@Model
final class Food {
    var id: UUID = UUID()
    var name: String
    var calories: Int

    init(name: String, calories: Int) {
        self.name = name
        self.calories = calories
    }
}
