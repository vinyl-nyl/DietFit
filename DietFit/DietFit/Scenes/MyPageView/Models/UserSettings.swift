//
//  UserSettings.swift
//  Dietfit
//
//  Created by 권도현 on 5/13/25.
//
import Foundation
import SwiftData

@Model
class UserSettings {
    var name: String
    var email: String
    var notificationEnabled: Bool
    var notificationTime: Date
    var unitSystem: String

    init(name: String = "",
         email: String = "",
         notificationEnabled: Bool = true,
         notificationTime: Date = Date(),
         unitSystem: String = "cm/kg") {
        self.name = name
        self.email = email
        self.notificationEnabled = notificationEnabled
        self.notificationTime = notificationTime
        self.unitSystem = unitSystem
    }
}


