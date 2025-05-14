//
//  SettingsView.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//
import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var userSettings = UserSettings.loadFromAppStorage()
    @AppStorage("notificationEnabled") private var notificationEnabled = true
    @AppStorage("notificationTime") private var notificationTime = Date()

    @State private var showUserInfoListView = false
    @State private var profileImage: Image? = nil
    @State private var showResetAlert = false

    @Query private var userInfos: [UserInfo]

    var body: some View {
        NavigationStack {
            Form {
                // 프로필 사진 설정
                VStack {
                    Button {
                        // 프로필 이미지 선택
                    } label: {
                        ZStack {
                            Circle()
                                .strokeBorder(Color.buttonPrimary, lineWidth: 2)
                                .frame(width: 80, height: 80)

                            if let profileImage = profileImage {
                                profileImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.buttonPrimary)
                                    .font(.system(size: 40))
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())

                    Text("프로필 사진 설정")
                        .foregroundColor(.buttonPrimary)
                        .padding(.top, 5)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)

                // 사용자 정보 설정
                VStack {
                    Button {
                        showUserInfoListView = true
                    } label: {
                        Text("사용자 정보 설정")
                            .tint(.buttonPrimary)
                    }
                    .sheet(isPresented: $showUserInfoListView) {
                        UserInfoListView()
                            .environment(\.modelContext, context)
                    }
                }

                // 알림 설정
                Section(header: Text("알림")) {
                    Toggle("알림 켜기/끄기", isOn: $notificationEnabled)
                        .padding()

                    DatePicker(
                        selection: $notificationTime,
                        displayedComponents: .hourAndMinute
                    ) {
                        Text("알림 시간")
                            .foregroundColor(notificationEnabled ? .primary : .gray)
                    }
                    .padding()
                    .disabled(!notificationEnabled)
                    .colorMultiply(notificationEnabled ? .primary : .gray.opacity(0.3))
                }

                // 단위 설정
                Section(header: Text("단위 설정")) {
                    Picker("단위 시스템", selection: $userSettings.unitSystem) {
                        Text("cm/kg").tag("cm/kg")
                        Text("ft/lbs").tag("ft/lbs")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }

                // 데이터 초기화
                Section {
                    Button(role: .destructive) {
                        showResetAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("모든 데이터 초기화")
                        }
                    }
                }
            }
            .navigationTitle("사용자 설정")
            .onChange(of: userSettings.name) {
                userSettings.saveToAppStorage()
            }
            .onChange(of: userSettings.email) {
                userSettings.saveToAppStorage()
            }
            .onChange(of: userSettings.notificationEnabled) {
                userSettings.saveToAppStorage()
            }
            .onChange(of: userSettings.notificationTime) {
                userSettings.saveToAppStorage()
            }
            .onChange(of: userSettings.unitSystem) {
                userSettings.saveToAppStorage()
            }
            .alert("모든 데이터를 초기화하시겠습니까?", isPresented: $showResetAlert) {
                Button("초기화", role: .destructive) {
                    resetAllData()
                }
                Button("취소", role: .cancel) {}
            } message: {
                Text("이 작업은 되돌릴 수 없습니다. 정말로 모든 데이터를 삭제하시겠습니까?")
            }
        }
    }

    func resetAllData() {
        do {
            try deleteAll(of: UserInfo.self)
            try deleteAll(of: RetroSpect.self)
        } catch {
            print("초기화 실패: \(error)")
        }
    }

    func deleteAll<T: PersistentModel>(of type: T.Type) throws {
        let descriptor = FetchDescriptor<T>()
        let items = try context.fetch(descriptor)
        for item in items {
            context.delete(item)
        }
    }
}

#Preview {
    SettingsView()
}
