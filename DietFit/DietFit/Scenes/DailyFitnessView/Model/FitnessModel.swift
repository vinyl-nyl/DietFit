//
//  FitnessModel.swift
//  DietFit
//
//  Created by Heejung Yang on 5/15/25.
//

import SwiftData
import Foundation

@Model
final class FitnessModel: Identifiable, Hashable  {
    var id = UUID()
    var insertDate: Date
    var area: String
    var exercise: String
    var calories: Int
    var duration: Int
    var intensity: Int

    init(id: UUID = UUID(), insertDate: Date = .now, area: String, exercise: String, calories: Int, duration: Int, intensity: Int) {
        self.id = id
        self.insertDate = insertDate
        self.area = area
        self.exercise = exercise
        self.calories = calories
        self.duration = duration
        self.intensity = intensity
    }
}
