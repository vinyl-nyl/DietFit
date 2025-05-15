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
    var name: String
    var insertDate: Date
    var area: String
    var exercise: String
    var calories: Int
    var duration: Int
    var intensity: String

    init(id: UUID = UUID(), name: String, insertDate: Date = .now, area: String, exercise: String, calories: Int, duration: Int, intensity: String) {
        self.id = id
        self.insertDate = insertDate
        self.name = name
        self.area = area
        self.exercise = exercise
        self.calories = calories
        self.duration = duration
        self.intensity = intensity
    }
}


