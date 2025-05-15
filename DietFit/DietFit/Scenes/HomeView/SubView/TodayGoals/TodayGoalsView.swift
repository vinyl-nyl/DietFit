//
//  TodayGoalsView.swift
//  DietFit
//
//  Created by junil on 5/13/25.
//
// HomeView: 하루 목표 달성 View

import SwiftUI
import SwiftData

struct TodayGoalsView: View {
    @EnvironmentObject var tabManager: TabSelectionManager

    @Query var goal: [Goal]

    var mealGoal: Int {
        goal.last(where: { $0.type == .meal })?.value ?? 2500
    }

    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color(.systemGray6))

                VStack(spacing: 0) {
                    HStack {
                        Text("하루 목표 달성")
                            .fontWeight(.semibold)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)

                        Spacer()
                    }

                    Rectangle()
                        .frame(height: 0.2)
                        .foregroundStyle(.primary)
                        .opacity(0.5)

                    HStack(spacing: 60) {
                        Button {
                            tabManager.selectedTabIndex = 2
                        } label: {
                            VStack(spacing: 10) {
                                CircularProgressView(iconName: "dumbbell.fill", goalKcal: 0, ongoingKcal: 0)
                            }
                        }

                        Button {
                            tabManager.selectedTabIndex = 1
                        } label: {
                            VStack(spacing: 10) {
                                CircularProgressView(iconName: "fork.knife", goalKcal: mealGoal, ongoingKcal: 0)
                            }
                        }
                    }
                    .foregroundStyle(.placeholder)
                    .padding(.vertical, 20)
                }
                .frame(maxWidth: .infinity)
            }

        }
    }
}

class TabSelectionManager: ObservableObject {
    @Published var selectedTabIndex: Int = 0
}

#Preview {
    TodayGoalsView()
}
