//
//  UserSettings.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//
import Foundation

class UserSettings: ObservableObject, Codable {
    var name: String = ""
    var email: String = ""
    var notificationEnabled: Bool = true
    var notificationTime: Date = Date()
    var unitSystem: String = "cm/kg"
    
    // UserSettings의 데이터를 UserDefaults에 저장
    func saveToAppStorage() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self) {
            UserDefaults.standard.set(data, forKey: "userSettings")
        }
    }
    
    // UserDefaults에 저장된 UserSettings 불러오기
    static func loadFromAppStorage() -> UserSettings {
        if let data = UserDefaults.standard.data(forKey: "userSettings") {
            let decoder = JSONDecoder()
            if let settings = try? decoder.decode(UserSettings.self, from: data) {
                return settings
            }
        }
        return UserSettings()  // 기본 값 반환
    }
}

