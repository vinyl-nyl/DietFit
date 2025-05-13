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
    @State private var userInfos: [UserInfo] = []
    @State private var showAddForm: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(userInfos) { userInfo in
                        HStack {
                            Text(userInfo.name)
                            Spacer()
                            Text("\(userInfo.age)세")
                            Text("\(userInfo.height, specifier: "%.1f") cm")
                            Text("\(userInfo.weight, specifier: "%.1f") kg")
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                if let index = userInfos.firstIndex(where: { $0.id == userInfo.id }) {
                                    userInfos.remove(at: index)
                                }
                            } label: {
                                Label("삭제", systemImage: "trash")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        userInfos.remove(atOffsets: indexSet)
                    }
                }
                .navigationTitle("사용자 정보")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showAddForm.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddForm) {
                    UserInfoFormView(userInfos: $userInfos)
                }
            }
        }
    }
}

#Preview {
    UserInfoListView()
}
