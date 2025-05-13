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
                    .swipeActions {
                        Button(role: .destructive) {
                            modelContext.delete(userInfo)
                        } label: {
                            Label("삭제", systemImage: "trash")
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
                    }
                }
            }
            .sheet(isPresented: $showAddForm) {
                UserInfoFormView()
            }
        }
    }
}

#Preview {
    UserInfoListView()
        .modelContainer(for: UserInfo.self, inMemory: true)
}

