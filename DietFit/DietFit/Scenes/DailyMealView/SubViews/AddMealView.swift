//
//  AddMealView.swift
//  DietFit
//
//  Created by 박동언 on 5/14/25.
//


import SwiftUI

struct AddMealView: View {
    @Environment(\.dismiss) private var dismiss

    let type: MealType

    var body: some View {
        VStack {
            Text("\(type.rawValue) 기록화면")
                .font(.title)
                .bold()
            // 음식 추가 UI 구성 예정
        }
        .navigationTitle("\(type.rawValue) 추가")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .tint(.primary)
                }
            }

//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//
//                } label: {
//
//                }
//            }
        }
    }
}
