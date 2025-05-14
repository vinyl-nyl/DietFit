//
//  CardMemoView.swift
//  DietFit
//
//  Created by 박동언 on 5/14/25.
//

import SwiftUI

struct CardMemoView: View {
    @Environment(\.colorScheme) private var colorScheme

    let width: CGFloat
    
    var body: some View {
        VStack(spacing: 16) {
            Text("메모")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, width * 0.1)
            
            Button {
                
            } label: {
                VStack {
                    Text("식단 일지를 기록하세요.")
                }
                .padding(8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            }
            .buttonStyle(.plain)
            .frame(width: width * 0.74, height: width * 0.3)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(colorScheme == .dark ? Color(.systemGray4) : Color(.systemGray6), lineWidth: 1)
            }
        }
        .frame(width: width * 0.9, height: width * 0.52)
        .modifier(CardStyleModifier())
    }
}

#Preview {
    CardMemoView(width: 300.0)
}
