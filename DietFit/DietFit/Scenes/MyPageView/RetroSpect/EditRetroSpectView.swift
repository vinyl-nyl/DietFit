//
//  EditGoalView.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//

//import SwiftUI
//import SwiftData
//
//struct EditRetroSpectView: View {
//    @Bindable var goal: Goal
//    @Environment(\.colorScheme) private var colorScheme
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View {
//        HStack {
//            Form {
//                Section(header: Text("목표 제목 수정")) {
//                    TextField("목표 제목", text: $goal.mealGoals)
//                }
//
//                Button {
//                    dismiss()
//                } label:{
//                    Text("저장")
//                        .tint(.buttonPrimary)
//                        .padding()
//                        .clipShape(.capsule)
//                }
//                .disabled(goal.title.isEmpty)
//            }
//            .navigationTitle("목표 수정")
//            .background(Color(.systemGray6))
//
//            .modifier(StyleModifier())
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(colorScheme == .dark ? .black : Color(.systemGray6))
//    }
//}
//
//#Preview {
//    EditRetroSpectView(goal: Goal(mealGoals: 1))
//        .modelContainer(for: Goal.self, inMemory: true)
//}
