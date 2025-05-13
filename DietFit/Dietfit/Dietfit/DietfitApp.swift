//
//  DietfitApp.swift
//  Dietfit
//
//  Created by 권도현 on 5/12/25.
//

import SwiftUI
import SwiftData

@main
struct DietfitApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Goal.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            MyGoalView()
//            UserInfoListView()
            MyPageView()
            
        }
//        .modelContainer(sharedModelContainer)
//        .modelContainer(for: UserInfo.self)

    }
}
