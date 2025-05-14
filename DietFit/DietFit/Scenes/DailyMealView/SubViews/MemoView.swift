//
//  MemoView.swift
//  DietFit
//
//  Created by 박동언 on 5/14/25.
//

import SwiftUI

struct MemoView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading) {
            Text("memo 기록화면")
            // 음식 추가 UI 구성 예정
        }
        .navigationTitle("메모 작성")
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

            ToolbarItem(placement: .topBarTrailing) {
                Button {

                } label: {
					Text("저장")
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    MemoView()
}
