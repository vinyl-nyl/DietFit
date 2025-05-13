//
//  CircularProgressView.swift
//  DietFit
//
//  Created by junil on 5/13/25.
//


import SwiftUI

struct CircularProgressView: View {
    var progress: Double // 0.0 ~ 1.0
    var iconName: String // SF Symbol 또는 이미지 이름
    
    var body: some View {
        ZStack {
            // 배경 원형
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
            
            // 진행 중인 원형
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    Color.green,
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
    }
}

#Preview {
    CircularProgressView(progress: 0.25, iconName: "airpodspro")
        .padding()
}
