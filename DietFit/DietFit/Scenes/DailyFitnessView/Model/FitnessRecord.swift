//
//  FitnessRecord.swift
//  DietFit
//
//  Created by Heejung Yang on 5/15/25.
//

import Foundation
import SwiftData

@Model
final class FitnessRecord {
    var date: Date
    var fitnessList: [FitnessModel]
    var memo: String?

    init(date: Date = Date().startOfDay, fitnessList: [FitnessModel], memo: String? = nil) {
        self.date = date
        self.fitnessList = fitnessList
        self.memo = memo
    }
}
