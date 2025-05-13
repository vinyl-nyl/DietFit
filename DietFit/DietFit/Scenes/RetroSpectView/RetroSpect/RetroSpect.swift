//
//  Item.swift
//  Dietfit
//
//  Created by 권도현 on 5/12/25.
//

import Foundation
import SwiftData

@Model
class RetroSpect: Identifiable {
    var id: UUID
    var title: String
    var createdAt: Date

    init(title: String) {
        self.id = UUID()
        self.title = title
        self.createdAt = Date()
    }
}
