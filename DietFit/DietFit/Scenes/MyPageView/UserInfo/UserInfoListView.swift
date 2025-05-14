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
    @Query private var userInfos: [UserInfo]

    @State private var showAddForm = false
    @State private var selectedUser: UserInfo?
    @State private var showEditForm = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(userInfos) { userInfo in
                    HStack {
                        Text(userInfo.name)
                        Spacer()
                        Text("\(userInfo.height, specifier: "%.1f") cm")
                        Text("\(userInfo.weight, specifier: "%.1f") kg")
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        // 삭제 버튼
                        Button(role: .destructive) {
                            modelContext.delete(userInfo)
                        } label: {
                            Label("삭제", systemImage: "trash")
                        }

                        // 수정 버튼
                        Button {
                            selectedUser = userInfo
                            showEditForm = true
                        } label: {
                            Label("수정", systemImage: "pencil")
                        }
                        .tint(.blue)
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
            // 수정 뷰 시트
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
