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
    var duration: Int
    var intensity: Int

    init(insertDate: Date = .now, area: String, exercise: String, duration: Int, intensity: Int) {
        self.insertDate = insertDate
        self.area = area
        self.exercise = exercise
        self.duration = duration
        self.intensity = intensity
    }
}
