//
//  CircularProgressView.swift
//  DietFit
//
//  Created by junil on 5/13/25.
//
// TodayGoalsView: Progress View

import SwiftUI

struct CircularProgressView: View {
    var iconName: String // SF Symbol 또는 이미지 이름
    var goalKcal: Int
    var ongoingKcal: Int

    var body: some View {
        let progress: Double = Double(ongoingKcal) / Double(goalKcal)

        VStack(spacing: 10) {
            ZStack {
                // 배경 원형
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 10)

                // 진행 중인 원형
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(
                        Color.buttonPrimary,
                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90)) // 시작점을 위로

                // 아이콘
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.secondary)
            }
            .frame(width: 100, height: 100)

            Text("\(ongoingKcal) / \(goalKcal)Kcal")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    CircularProgressView(iconName: "airpodspro", goalKcal: 2000, ongoingKcal: 941)
        .padding()
}
