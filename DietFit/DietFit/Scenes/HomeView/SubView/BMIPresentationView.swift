//
//  BMIPresentationView.swift
//  DietFit
//
//  Created by junil on 5/13/25.
//
// HomeView: Today's BMI sheet View

import SwiftUI

struct BMIPresentationView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("BMI 수치 기준")
                .font(.headline)
            BMIColor(circleColor: .red, text: "비만")
            BMIColor(circleColor: .yellow, text: "과체중")
            BMIColor(circleColor: .green, text: "정상")
            BMIColor(circleColor: .secondary, text: "저체중")
        }

        Spacer()

        VStack(alignment: .trailing, spacing: 8) {
            Text("BMI 범위")
                .font(.headline)

            VStack(alignment: .trailing, spacing: 8) {
                Text("30.0 ~")
                Text("25.0 ~ 29.9")
                Text("18.5 ~ 24.9")
                Text("~ 18.5")
            }
            .font(.callout)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    BMIPresentationView()
}
