//
//  ContentView.swift
//  DietFit
//
//  Created by junil on 5/12/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var tabManager = TabSelectionManager()
    @StateObject private var vm = DailyMealViewModel()

    var body: some View {
        TabView(selection: $tabManager.selectedTabIndex) {
            HomeView()
                .tabItem {
                    Label("요약", systemImage: "chart.bar.horizontal.page")
                }
                .tag(0)

            DailyMealView(mealVM: vm)
                .tabItem {
                    Label("식단", systemImage: "fork.knife")
                }
                .tag(1)

             DailyFitnessView(mealVM: vm) // 주석 처리된 뷰
                 .tabItem {
                     Label("운동", systemImage: "dumbbell.fill")
                 }
                 .tag(3)

            MyPageView()
                .tabItem {
                    Label("내 정보", systemImage: "person.fill")
                }
                .tag(2)
        }
        .tint(.buttonPrimary)
        .environmentObject(tabManager)
        .environmentObject(vm)
    }
}

#Preview {
    ContentView()
        .environment(\.locale, Locale(identifier: "ko_kr"))
}
