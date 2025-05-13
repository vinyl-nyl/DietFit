//
//  SettingsView.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var userSettings = UserSettings.loadFromAppStorage()  
    @State private var showUserInfoListView = false
    
    
    var body: some View {
        NavigationStack {
            Form {
                
                VStack {
                    Button{
                        showUserInfoListView = true
                    } label: {
                        Text("사용자 정보 설정")
                    }
                    .sheet(isPresented: $showUserInfoListView) {
                        UserInfoListView()
                    }
                }
                
                // 알림 설정
                Section(header: Text("알림")) {
                    Toggle("알림 켜기/끄기", isOn: $userSettings.notificationEnabled)
                        .padding()
                    
                    DatePicker("알림 시간", selection: $userSettings.notificationTime, displayedComponents: .hourAndMinute)
                        .padding()
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
            }
            .navigationTitle("사용자 설정")
            // 새로운 onChange 문법을 사용하여 상태 변경 시 저장 처리
            .onChange(of: userSettings.name) {
                userSettings.saveToAppStorage()  // 이름이 변경되면 저장
            }
            .onChange(of: userSettings.email) {
                userSettings.saveToAppStorage()  // 이메일이 변경되면 저장
            }
            .onChange(of: userSettings.notificationEnabled) {
                userSettings.saveToAppStorage()  // 알림 설정이 변경되면 저장
            }
            .onChange(of: userSettings.notificationTime) {
                userSettings.saveToAppStorage()  // 알림 시간이 변경되면 저장
            }
            .onChange(of: userSettings.unitSystem) {
                userSettings.saveToAppStorage()  // 단위 시스템이 변경되면 저장
            }
        }
    }
    
}

#Preview {
    SettingsView()
}
