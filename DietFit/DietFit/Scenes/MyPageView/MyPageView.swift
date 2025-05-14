//
//  MyPageView.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//


import SwiftUI

struct MyPageView: View {
    @State private var showMyGoalView = false
    @State private var showUserInfoListView = false
    @State private var showSettingsView = false

    var body: some View {
        NavigationStack {
            VStack {
               
                Button{
                showMyGoalView.toggle()
                } label: {
                    Text("나의 목표 설정")
                }
                .padding()
                .sheet(isPresented: $showMyGoalView) {
                    RetroSpectView()
                }
                
                // UserInfoListView 버튼
                Button{showUserInfoListView.toggle()
                } label: {
                    Text("사용자 정보 목록")
                }
                .padding()
                .sheet(isPresented: $showUserInfoListView) {
                    UserInfoListView()
                }
                
                Button{showSettingsView.toggle()
                } label: {
                    Text("설정")
                }
                .padding()
                .sheet(isPresented: $showSettingsView) {
//                    SettingsView()
                }
            }
            .navigationTitle("마이페이지")
        }
    }
}

#Preview {
    MyPageView()
        .modelContainer(for: [UserInfo.self, RetroSpect.self], inMemory: true)
}

