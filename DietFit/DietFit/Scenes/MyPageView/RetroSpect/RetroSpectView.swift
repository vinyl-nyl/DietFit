//
//  ContentView.swift
//  Dietfit
//
//  Created by 권도현 on 5/12/25.
//
import SwiftUI
import SwiftData

struct RetroSpectView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme

    @Query private var goals: [Goal]

    @State private var mealGoal: String = ""
    @State private var fitGoal: String = ""

    @State private var showAlert = false

    @State private var alertMessage: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("나의목표")
                        .font(.largeTitle)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()

                HStack {
                    Text("식단")
                        .font(.title3)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                TextField("식단 목표 입력", text: $mealGoal)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .tint(.buttonPrimary)

                HStack {
                    Text("운동")
                        .font(.title3)
                        .bold()
                }
                .padding(.top, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                TextField("운동 목표 입력", text: $fitGoal)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .tint(.buttonPrimary)


                Button {
                    guard !mealGoal.isEmpty || !fitGoal.isEmpty else {
                        alertMessage = "최소 하나의 목표를 입력해주세요."
                        showAlert = true
                        return
                    }

                    guard let mealGoalInt = Int(mealGoal), mealGoalInt > 0 else {
                         alertMessage = "식단 목표는 0보다 큰 숫자로 입력해주세요."
                         showAlert = true
                         return
                     }

                     guard let fitGoalInt = Int(fitGoal), fitGoalInt > 0 else {
                         alertMessage = "운동 목표는 0보다 큰 숫자로 입력해주세요."
                         showAlert = true
                         return
                     }

                    addGoal(value: mealGoalInt, type: .meal)
                    addGoal(value: fitGoalInt, type: .fitness)

                } label: {
                    Text("저장")
                        .font(.title3)
                               .bold()
                               .foregroundStyle(.white)
                               .frame(maxWidth: .infinity)
                               .padding()
                               .background(Color.buttonPrimary)
                               .clipShape(Capsule())
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("입력 오류"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
                }

                Divider()

                List {
                    Section(header: Text("식단 목표 목록")) {
                        ForEach(goals.filter { $0.type == .meal }) { goal in
                            Text("식단 목표 \(goal.value)")
                                .font(.headline)
                        }
                        .onDelete { indexSet in deleteGoals(offsets: indexSet, type: .meal) }
                    }

                    Section(header: Text("운동 목표 목록")) {
                        ForEach(goals.filter { $0.type == .fitness }) { goal in
                            Text("운동 목표 \(goal.value)")
                                .font(.headline)
                        }
                        .onDelete { indexSet in deleteGoals(offsets: indexSet, type: .fitness) }
                    }
                }
            }
            .modifier(StyleModifier())
            .background(Color(.systemGray6))
        }
    }

    private func addGoal(value: Int, type: GoalType) {
        let goal = Goal(value: value, type: type)
        context.insert(goal)
        do {
            try context.save()
            if type == .meal {
                mealGoal = ""
            } else {
                fitGoal = ""
            }
        } catch {
            print("Error saving goal: \(error)")
        }
    }

    private func deleteGoals(offsets: IndexSet, type: GoalType) {
        let filteredGoals = goals.filter { $0.type == type }
        for index in offsets {
            context.delete(filteredGoals[index])
        }
        do {
            try context.save()
        } catch {
            print("Error deleting goal: \(error)")
        }
    }
}

#Preview {
    RetroSpectView()
    //        .modelContainer(for: RetroSpect.self, inMemory: true)
}

