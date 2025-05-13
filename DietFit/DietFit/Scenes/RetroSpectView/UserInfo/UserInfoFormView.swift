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
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""

    @Binding var userInfos: [UserInfo]  // 리스트에서 정보를 받아옵니다.

    var body: some View {
        Form {
            Section(header: Text("사용자 정보 입력")) {
                TextField("이름", text: $name)
                TextField("나이", text: $age)
                    .keyboardType(.numberPad)
                TextField("키 (cm)", text: $height)
                    .keyboardType(.decimalPad)
                TextField("몸무게 (kg)", text: $weight)
                    .keyboardType(.decimalPad)
            }

            Button("저장") {
                if let age = Int(age), let height = Double(height), let weight = Double(weight) {
                    let newUser = UserInfo(name: name, age: age, height: height, weight: weight)
                    userInfos.append(newUser)
                }
                clearFields()
            }
        }
        .navigationTitle("사용자 정보 입력")
    }

    private func clearFields() {
        name = ""
        age = ""
        height = ""
        weight = ""
    }
}

#Preview {
    UserInfoFormView(userInfos: .constant([]))
}
