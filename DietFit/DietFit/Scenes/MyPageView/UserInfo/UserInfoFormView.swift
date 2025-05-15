//
//  UserInfoFormView.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//


import SwiftUI
import SwiftData

struct UserInfoFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var height = ""
    @State private var weight = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("이름", text: $name)
                TextField("키 (cm)", text: $height)
                    .keyboardType(.decimalPad)
                TextField("몸무게 (kg)", text: $weight)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("새 사용자")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        guard let heightDouble = Double(height),
                              let weightDouble = Double(weight) else {
                            return
                        }

                        let newUser = UserInfo(name: name, height: heightDouble, weight: weightDouble, bmi: nil)
                        modelContext.insert(newUser)
                        dismiss()
                    } label: {
                        Text("저장")
                            .tint(.buttonPrimary)
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                            .tint(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    UserInfoFormView()
        .modelContainer(for: UserInfo.self, inMemory: true)
}
