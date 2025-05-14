//
//  ContentView.swift
//  Dietfit
//
//  Created by 권도현 on 5/12/25.
//
import SwiftUI
import SwiftData

struct RetroSpectView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    @Query private var goals: [RetroSpect]

    @AppStorage("newGoalText") private var newGoalText: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("새 목표 입력", text: $newGoalText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button {
                    addGoal()
                } label: {
                Text("목표 추가")
                        .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(.buttonPrimary)
                                )
                }
                .disabled(newGoalText.isEmpty)
                .padding()

                Divider()

                List {
                    Section(header: Text("목표 목록")) {
                        ForEach(goals) { goal in
                            NavigationLink(destination: EditRetroSpectView(goal: goal)) {
                                VStack(alignment: .leading) {
                                    Text(goal.title)
                                        .font(.headline)
                                    Text(goal.createdAt, format: .dateTime.year().month().day())
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .onDelete(perform: deleteGoals)
                    }
                }
            }
            .navigationTitle("나의 목표")
            .toolbar {
                EditButton()
                    .tint(.buttonPrimary)
            }
        }
    }

    private func addGoal() {
        let newGoal = RetroSpect(title: newGoalText)
        modelContext.insert(newGoal)
        newGoalText = ""
    }

    private func deleteGoals(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(goals[index])
        }
    }
}

#Preview {
    RetroSpectView()
        .modelContainer(for: RetroSpect.self, inMemory: true)
}
