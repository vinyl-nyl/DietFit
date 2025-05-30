//
//  UserInfo.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//


import Foundation
import SwiftData

@Model
class UserInfo {
    var name: String
    var height: Double
    var weight: Double
    var detail: String?
    var createdAt: Date
    var bmi: Double?

    init(name: String, height: Double, weight: Double, detail: String? = nil, bmi: Double?) {
        self.name = name
        self.height = height
        self.weight = weight
        self.detail = detail
        self.createdAt = Date.now
        self.bmi = weight / ((height/100) * (height/100))
    }
}
