//
//  UserInfo.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//


import SwiftData
import Foundation

@Model
class UserInfo: Identifiable {
     var id: UUID
     var name: String = ""
     var age: Int = 0
     var height: Double = 0.0
     var weight: Double = 0.0

    init(name: String, age: Int, height: Double, weight: Double) {
        self.id = UUID()
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
    }
}

