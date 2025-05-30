//
//  CardMemoView.swift
//  DietFit
//
//  Created by 박동언 on 5/14/25.
//

import SwiftUI
import SwiftData

struct CardMemoView: View {
    @Environment(\.colorScheme) private var colorScheme
    @ObservedObject var mealVM: DailyMealViewModel

    @Query private var mealRecords: [MealRecord]

    var type: MemoType

    // 해딩 닐짜의 메모 불러오기
    var todayMealMemo: String? {
        mealRecords.first(where: { $0.date == mealVM.selectedDate})?.mealMemo
    }

    var todayFitnessMemo: String? {
        mealRecords.first(where: { $0.date == mealVM.selectedDate})?.fitnessMemo
    }

    var body: some View {
        Text("오늘의 메모")
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)

        NavigationLink {
            ComposeMemoView(mealVM: mealVM)
                .padding()
        } label: {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)

                switch type {
                case .fitness:
                    if let memo = todayFitnessMemo, !memo.isEmpty {
                        Text(memo)
                            .foregroundStyle(.primary)
                            .padding()
                    } else {
                        Text("운동 일지를 기록하세요.\n느낀 점이나 회고도 좋아요.")
                            .foregroundStyle(.secondary)
                            .padding()
                    }

                case .meal:
                    if let memo = todayMealMemo, !memo.isEmpty {
                        Text(memo)
                            .foregroundStyle(.primary)
                            .padding()
                    } else {
                        Text("식단 일지를 기록하세요.\n느낀 점이나 회고도 좋아요.")
                            .foregroundStyle(.secondary)
                            .padding()
                    }
                }
            }
            .buttonStyle(.plain)
            .frame(height: 180)
        }
    }
}

#Preview {
    CardMemoView(mealVM: DailyMealViewModel(), type: .meal)
}

