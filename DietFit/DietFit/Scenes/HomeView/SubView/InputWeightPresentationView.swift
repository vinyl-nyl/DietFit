//
//  InputWeightPresentationView.swift
//  DietFit
//
//  Created by junil on 5/14/25.
//

import SwiftUI

struct InputWeightPresentationView: View {
    @State private var showWeightInput = false
    @State private var inputWeight: String = ""
    
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
                .tint(.green)
            }
            .padding(.horizontal)
            .padding(.top)

            Spacer().frame(height: 20)

            // 본문 영역
            VStack(spacing: 20) {
                Text("오늘의 몸무게를 입력해주세요")
                    .font(.headline)

                TextField("몸무게 (kg)", text: $inputWeight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    InputWeightPresentationView()
}
