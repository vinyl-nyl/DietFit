//
//  UserDetailEditView.swift
//  DietFit
//
//  Created by 권도현 on 5/14/25.
//

import SwiftUI
import SwiftData

struct UserDetailEditView: View {
    @Bindable var userInfo: UserInfo
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("이름")) {
                    TextField("이름", text: $userInfo.name)
                }

                Section(header: Text("키 (cm)")) {
                    TextField("키", value: $userInfo.height, format: .number)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("몸무게 (kg)")) {
                    TextField("몸무게", value: $userInfo.weight, format: .number)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("부가 설명")) {
                    TextField("내용을 입력하세요", text: $userInfo.detail.bound)
                        .lineLimit(5)
                }
            }
            .navigationTitle("사용자 수정")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
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
                            .tint(.buttonPrimary)
                    }
                }
            }

        }
    }
}

extension Binding where Value == String? {
    var bound: Binding<String> {
        Binding<String>(
            get: { self.wrappedValue ?? "" },
            set: { self.wrappedValue = $0 }
        )
    }
}

#Preview {
    UserDetailEditView(userInfo: UserInfo(name: "", height: 0.0, weight: 0.0, detail: "", bmi: nil))
        .modelContainer(for: UserInfo.self, inMemory: true)
}
