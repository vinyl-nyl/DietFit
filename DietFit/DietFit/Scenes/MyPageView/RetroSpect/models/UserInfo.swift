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
    var detail: String? // 부가 설명
    var createdAt: Date // ✅ 저장 시간

    init(name: String, height: Double, weight: Double, detail: String? = nil, createdAt: Date = Date()) {
        self.name = name
        self.height = height
        self.weight = weight
        self.detail = detail
        self.createdAt = createdAt
    }
}

