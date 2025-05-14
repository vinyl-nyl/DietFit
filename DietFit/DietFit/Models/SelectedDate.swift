//
//  SelectedDate.swift
//  DietFit
//
//  Created by 박동언 on 5/14/25.
//

import SwiftData
import Foundation

@Model
final class SelectedDate {
    var date: Date
    var userInfo: UserInfo

    init(date: Date, userInfo: UserInfo) {
        self.date = date
        self.userInfo = userInfo
    }
}
