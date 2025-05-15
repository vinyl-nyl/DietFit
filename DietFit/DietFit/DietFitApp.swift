//
//  DietFitApp.swift
//  DietFit
//
//  Created by junil on 5/12/25.
//

import SwiftUI
import SwiftData

@main
struct DietFitApp: App {
    var body: some Scene {
        var sharedModelContainer: ModelContainer = {
            let schema = Schema([
                UserInfo.self,
                RetroSpect.self,
                FitnessModel.self,
                MealRecord.self,
                Meal.self,
                Food.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()

        WindowGroup {
//            StartView()
            ContentView()
//            DailyMealView()
///*            */StartView()
        }
        .modelContainer(sharedModelContainer)
    }
}
