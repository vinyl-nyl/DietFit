//
//  RoundedBoardertextField.swift
//  DietFit
//
//  Created by 권도현 on 5/15/25.
//


import SwiftUI

struct CustomTextField: View {
    let title: String
    let systemName: String
    @Binding var value: String
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        HStack {
            Image(systemName: systemName)
                .symbolVariant(.fill)
                .foregroundColor(colorScheme == .dark ? Color.white : .black)
                TextField(title, text: $value)
                .foregroundColor(.black)
            
        }
        .padding()
        .background(
            Capsule()
                .fill(colorScheme == .dark ? Color(.systemGray6) : .white)
        )
        .overlay{
            Capsule()
                .stroke(Color.buttonPrimary, lineWidth: 2)
        }
        .clipShape(Capsule()) // ✅ 배경과 테두리를 벗어나지 않도록 클리핑
        .padding(10) // ✅ 외부 간격은 마지막에
    }
}



#Preview {
    CustomTextField(title: "사용자정보", systemName: "person", value: .constant(""))
}
