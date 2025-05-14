//
//  MyPageView.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//


import SwiftUI
import SwiftData

struct MyPageView: View {
    @State private var showMyGoalView = false
    @State private var showUserInfoListView = false
    @State private var showSettingsView = false

    @State private var userName: String = "홍길동"
    @State private var userHeight: Double = 175
    @State private var userWeight: Double = 68
    @State private var userDetail: String? = nil

    @Environment(\.modelContext) private var context
    @Query private var userInfos: [UserInfo]  // UserInfo 데이터를 불러옴

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // 사용자 정보 표시
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.buttonPrimary)
                            Spacer()
                            VStack(alignment: .leading) {
                                Text(userName)
                                    .font(.title2)
                                    .bold()
                                Text("키: \(Int(userHeight))cm  몸무게: \(Int(userWeight))kg")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                if let detail = userDetail {
                                    Text(detail)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(width: 360)
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.buttonPrimary, lineWidth: 2)
                    )

                    // 목표 설정 버튼
                    descriptionCard(text: "매일 나만의 목표를 설정하고, 본인이 목표를 달성했는지에 대한 내용을 기록하세요.")
                    Button {
                        showMyGoalView.toggle()
                    } label: {
                        buttonLabel(text: "나의 목표 설정", opacity: 1.0)
                    }
                    .sheet(isPresented: $showMyGoalView) {
                        RetroSpectView()
                    }

                    // 사용자 정보 목록 버튼
                    descriptionCard(text: "이름, 키, 몸무게 등 이용하는 여러분들의 정보를 리스트로 확인하고 관리할 수 있어요.")
                    Button {
                        showUserInfoListView.toggle()
                    } label: {
                        buttonLabel(text: "사용자 정보 목록", opacity: 0.8)
                    }
                    .sheet(isPresented: $showUserInfoListView) {
                        UserInfoListView()
                            .onAppear {
                                // 데이터가 로드되면 첫 번째 사용자 정보를 가져옴
                                if let user = userInfos.first {
                                    self.userName = user.name
                                    self.userHeight = user.height
                                    self.userWeight = user.weight
                                    self.userDetail = user.detail
                                }
                            }
                    }

                    // 설정 버튼
                    descriptionCard(text: "알림, 단위, 데이터 초기화 등 앱의 다양한 설정을 변경 및 초기화를 할 수 있어요.")
                    Button {
                        showSettingsView.toggle()
                    } label: {
                        buttonLabel(text: "설정", opacity: 0.6)
                    }
                    .sheet(isPresented: $showSettingsView) {
                        SettingsView()
                    }
                }
                .padding()
                .navigationTitle("마이페이지")
            }
        }
    }

    // Description 카드
    func descriptionCard(text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding()
            .frame(width: 360, height: 110, alignment: .leading)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(20)
    }

    // 버튼 레이블
    func buttonLabel(text: String, opacity: Double) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.buttonPrimary.opacity(opacity))
                .frame(width: 360, height: 70)
            Text(text)
                .font(.title3)
                .foregroundColor(.white)
                .bold()
        }
    }
}

#Preview {
    MyPageView()
        .modelContainer(for: [UserInfo.self], inMemory: true)
}
