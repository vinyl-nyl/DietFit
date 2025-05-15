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
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var context
    @Query private var userInfos: [UserInfo]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.buttonPrimary)
                                Spacer()
                            VStack(alignment: .trailing) {
                                Text(userName)
                                    .font(.title2)
                                    .bold()
                                Text("키: \(Int(userHeight))cm 몸무게: \(Int(userWeight))kg")
                                    .font(.subheadline)
                                    .tint(colorScheme == .dark ? Color(.systemGray6) : .black)
                                if let detail = userDetail {
                                    Text(detail)
                                        .font(.footnote)
                                        .tint(colorScheme == .dark ? Color(.systemGray6) : .black)
                                }
                            }
                            
                        }
                    }
                    .padding(20)
                    .frame(width: 360)

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
                        buttonLabel(text: "사용자 정보 목록", opacity: 1.0)
                    }
                    .sheet(isPresented: $showUserInfoListView) {
                        UserInfoListView()
                            .onAppear {
                               
                                if let user = userInfos.first {
                                    self.userName = user.name
                                    self.userHeight = user.height
                                    self.userWeight = user.weight
                                    self.userDetail = user.detail
                                }
                            }
                    }

                   
                    descriptionCard(text: "알림, 단위, 데이터 초기화 등 앱의 다양한 설정을 변경 및 초기화를 할 수 있어요.")
                    Button {
                        showSettingsView.toggle()
                    } label: {
                        buttonLabel(text: "설정", opacity: 1.0)
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

   
    func descriptionCard(text: String) -> some View {
        Text(text)
            .tint(colorScheme == .dark ? Color(.systemGray6) : .black)
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding()
            .frame(height: 90)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .background(colorScheme == .dark ? Color(.systemGray6) : .white)
            .cornerRadius(20)
    }

    
    func buttonLabel(text: String, opacity: Double) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.buttonPrimary.opacity(opacity))
                .frame(maxWidth: .infinity)
                .frame(height: 50)
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
