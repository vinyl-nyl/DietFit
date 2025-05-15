//
//  MemoView.swift
//  DietFit
//
//  Created by Heejung Yang on 5/15/25.
//

import SwiftUI
import SwiftData

struct MemoView: View {
    @Environment(\.colorScheme) private var colorScheme

    @ObservedObject var fitnessVM: DailyFitnessViewModel

    @Query private var mealRecords: [MealRecord]

    var todayMemo: String? {
        mealRecords.first(where: { $0.date == fitnessVM.selectedDate})?.mealMemo
    }

    var body: some View {
        Text("메모")
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 40)

        NavigationLink {
//            ComposeMemoView(mealVM: fitnessVM)
        } label: {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)

                if let memo = todayMemo, !memo.isEmpty {
                    Text(memo)
                        .foregroundStyle(.primary)
                        .padding()
                } else {
                    Text("식단 일지를 기록하세요.\n느낀점이나 회고도 좋아요.")
                        .foregroundStyle(.secondary)
                        .padding()
                }
            }
            .buttonStyle(.plain)
            .frame(height: 180)
        }
    }
}

#Preview {
    CardMemoView(mealVM: DailyMealViewModel())
}
