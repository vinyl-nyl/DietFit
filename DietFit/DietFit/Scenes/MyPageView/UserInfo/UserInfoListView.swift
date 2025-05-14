//
//  UserInfoListView.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//

import SwiftUI
import SwiftData

struct UserInfoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \UserInfo.name) private var userInfos: [UserInfo]

    @State private var showAddForm = false
    @State private var selectedUser: UserInfo?
    @State private var showEditForm = false

    var body: some View {
        NavigationStack {
            List {
                if userInfos.isEmpty {
                    Text("저장된 사용자 정보가 없습니다.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(userInfos) { userInfo in
                        HStack {
                            Text(userInfo.name)
                            Spacer()
                            Text("\(userInfo.height, specifier: "%.1f") cm")
                            Text("\(userInfo.weight, specifier: "%.1f") kg")
                        }
                        .swipeActions(allowsFullSwipe: false) {
                            // 삭제
                            Button(role: .destructive) {
                                modelContext.delete(userInfo)
                                try? modelContext.save()
                            } label: {
                                Label("삭제", systemImage: "trash")
                            }

                            // 수정
                            Button {
                                selectedUser = userInfo
                            } label: {
                                Label("수정", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            .navigationTitle("사용자 정보")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddForm.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .tint(.buttonPrimary)
                    }
                }
            }
            .sheet(isPresented: $showAddForm) {
                UserInfoFormView()
            }
            .sheet(item: $selectedUser) { user in
                UserDetailEditView(userInfo: user)
            }
        }
    }
}


#Preview {
    UserInfoListView()
        .modelContainer(for: UserInfo.self, inMemory: true)
}
