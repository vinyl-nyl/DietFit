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
    @State private var showStartView = false
    @Environment(\.colorScheme) private var colorScheme

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
                                deleteUser(userInfo)
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
            .fullScreenCover(isPresented: $showStartView) {
                StartView() // 사용자 전부 삭제되면 StartView로 전환
            }
        }
    }

    private func deleteUser(_ user: UserInfo) {
        modelContext.delete(user)
        try? modelContext.save()

        // 삭제 후 userInfos가 비어있으면 StartView로 이동
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if userInfos.isEmpty {
                showStartView = true
            }
        }
    }
}

#Preview {
    UserInfoListView()
        .modelContainer(for: UserInfo.self, inMemory: true)
}
