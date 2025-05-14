//
//  InputWeightPresentationView.swift
//  DietFit
//
//  Created by junil on 5/14/25.
//

import SwiftUI

struct InputWeightPresentationView: View {
    @Binding var showWeightInput: Bool
    @Binding var inputWeight: String

    var body: some View {
        VStack {
            HStack {
                Button("취소") {
                    showWeightInput = false
                }

                .tint(.red)

                Spacer()

                Button("확인") {
                    if Double(inputWeight) != nil {
                        showWeightInput = false
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.buttonPrimary)
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 30)

            Spacer().frame(height: 20)

            // 본문 영역
            VStack(spacing: 30) {
                Text("몸무게를 입력해주세요")
                    .font(.title2)
                    .fontWeight(.semibold)

                TextField("몸무게 (kg)", text: $inputWeight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
        }
    }
}
