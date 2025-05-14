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
    @Attribute(.unique) var id: UUID
    var name: String
    var height: Double
    var weight: Double

    init(id: UUID = UUID(), name: String, height: Double, weight: Double) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
    }
}

