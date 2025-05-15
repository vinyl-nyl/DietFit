//
//  MemoType.swift
//  DietFit
//
//  Created by 박동언 on 5/15/25.
//

enum MemoType: String, CaseIterable, Identifiable {
    case meal = "식단"
    case fitness = "운동"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .meal: return "star"
        case .fitness: return "figure.walk"
        }
    }

    var placeholder: String {
        switch self {
        case .meal: return "식단 일지를 기록하세요."
        case .fitness: return "운동 일지를 기록하세요."
        }
    }
}
