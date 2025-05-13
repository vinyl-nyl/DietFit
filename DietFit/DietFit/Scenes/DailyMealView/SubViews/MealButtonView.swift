//
//  ExtractedView.swift
//  DietFit
//
//  Created by 박동언 on 5/13/25.
//

import SwiftUI

struct MealButtonView: View {
    let title: String
    let size: CGFloat
    
    var body: some View {
        Button {
            // 버튼 동작
        } label: {
            Text(title)
                .frame(width: size, height: size)
                .background(Color("ButtonPrimary"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .buttonStyle(.plain)
    }
}
