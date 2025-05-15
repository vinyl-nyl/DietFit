//
//  DummyDataGeneratorView.swift
//  DietFit
//
//  Created by junil on 5/16/25.
//


import SwiftUI
import SwiftData

struct DummyDataGeneratorView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack(spacing: 20) {
            Button("") {
                generateDummyData(forDays: 200)
            }
        }
        .padding()
    }

    func generateDummyData(forDays days: Int) {
        let calendar = Calendar.current
        let baseName = "User"

        var previousWeight = Double.random(in: 90...100)
        let height = 183.0

        for i in 0..<days {
            guard let date = calendar.date(byAdding: .day, value: -i, to: Date()) else { continue }

            // 하루에 ±0.3kg 이내로 변화
            let weightChange = Double.random(in: -0.3...0.3)
            let weight = max(40, previousWeight + weightChange) // 최소값 방어
            previousWeight = weight

            let bmi = weight / ((height / 100) * (height / 100))

            let user = UserInfo(
                name: "\(baseName) \(i)",
                height: height,
                weight: weight,
                bmi: bmi
            )

            user.createdAt = calendar.startOfDay(for: date)

            modelContext.insert(user)
        }

        do {
            try modelContext.save()
            print("✅ 더미 데이터 저장 완료")
        } catch {
            print("❌ 저장 실패: \(error.localizedDescription)")
        }
    }
}
