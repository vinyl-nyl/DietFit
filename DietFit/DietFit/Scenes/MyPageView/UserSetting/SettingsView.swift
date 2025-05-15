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
    @Query private var settingsList: [UserSettings]
    @Query private var userInfos: [UserInfo]

    @State private var userSettings: UserSettings?
    @State private var showUserInfoListView = false
    @State private var profileImage: Image? = nil
    @State private var showResetAlert = false
    @State private var goToStartView = false

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationStack {
            Form {
                // 프로필 사진 설정
                VStack {
                    Button {
                        // 프로필 이미지 선택 로직 (예: PhotoPicker)
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
                if let settings = userSettings {
                    let notificationEnabledBinding = Binding<Bool>(
                        get: { settings.notificationEnabled },
                        set: { settings.notificationEnabled = $0 }
                    )

                    let notificationTimeBinding = Binding<Date>(
                        get: { settings.notificationTime },
                        set: { settings.notificationTime = $0 }
                    )

                    Section(header: Text("알림")) {
                        Toggle("알림 켜기/끄기", isOn: notificationEnabledBinding)
                            .padding()

                        DatePicker(
                            selection: notificationTimeBinding,
                            displayedComponents: .hourAndMinute
                        ) {
                            Text("알림 시간")
                                .foregroundColor(settings.notificationEnabled ? .primary : .gray)
                        }
                        .padding()
                        .disabled(!settings.notificationEnabled)
                        .colorMultiply(settings.notificationEnabled ? .primary : .gray.opacity(0.3))
                    }
                }

                // 데이터 초기화
                Section {
                    Button {
                        showResetAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("모든 데이터 초기화")
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("사용자 설정")
            .onAppear {
                loadOrCreateUserSettings()
            }
            .alert("모든 데이터를 초기화하시겠습니까?", isPresented: $showResetAlert) {
                Button(role: .destructive) {
                    resetAllData()
                } label: {
                    Text("초기화")
                }

                Button(role: .cancel) {
                    // 취소
                } label: {
                    Text("취소")
                }
            } message: {
                Text("이 작업은 되돌릴 수 없습니다. 정말로 모든 데이터를 삭제하시겠습니까?")
            }
           
            .fullScreenCover(isPresented: $goToStartView) {
                StartView()
                    .environment(\.modelContext, context)
            }
        }
    }

    private func loadOrCreateUserSettings() {
        if let existing = settingsList.first {
            userSettings = existing
        } else {
            let newSettings = UserSettings()
            context.insert(newSettings)
            userSettings = newSettings
            try? context.save()
        }
    }

    private func resetAllData() {
        do {
            userSettings = nil

            try deleteAll(of: UserInfo.self)
            try deleteAll(of: RetroSpect.self)
            try deleteAll(of: UserSettings.self)
            try context.save()

            // StartView를 시트로 띄우도록 설정
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                goToStartView = true
            }

        } catch {
            print("초기화 실패: \(error)")
        }
    }

    private func deleteAll<T: PersistentModel>(of type: T.Type) throws {
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

