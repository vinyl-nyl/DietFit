//
//  EditGoalView.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//

import SwiftUI
import SwiftData

struct EditRetroSpectView: View {
    @Bindable var goal: RetroSpect
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section(header: Text("목표 제목 수정")) {
                TextField("목표 제목", text: $goal.title)
            }

            Button("저장") {
                dismiss()
            }
            .disabled(goal.title.isEmpty)
        }
        .navigationTitle("목표 수정")
    }
}

