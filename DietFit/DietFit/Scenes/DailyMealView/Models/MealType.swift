//
//  MealType.swift
//  DietFit
//
//  Created by 박동언 on 5/13/25.
//

import SwiftUI

enum MealType: String, CaseIterable, Identifiable {
    case breakfast = "아침"
    case lunch = "점심"
    case dinner = "저녁"
    case snack = "간식"

    var id: String { rawValue }

    var icon:String {
        switch self {
        case .breakfast: return "sun.max.fill"
        case .lunch: return "takeoutbag.and.cup.and.straw.fill"
        case .dinner: return "moon.fill"
        case .snack: return "cup.and.saucer.fill"
        }
    }
}
