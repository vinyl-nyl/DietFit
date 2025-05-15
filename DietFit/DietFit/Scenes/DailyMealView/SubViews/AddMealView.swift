//
//  AddMealView.swift
//  DietFit
//
//  Created by 박동언 on 5/14/25.
//

import SwiftUI
import SwiftData

struct AddMealView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Query var records: [MealRecord]

    @State private var foodName: String = ""
    @State private var calories: String = ""
    @State private var foods: [Food] = []

    @State private var showAlert: Bool = false

    @State private var alertMessage: String = ""

    let mealType: MealType

    let today = Date().startOfDay

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("음식 이름")
                        .font(.title3)
                        .bold()
                    Text("(필수)")
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding(.horizontal)
                .padding(.top, 15)
                .frame(maxWidth: .infinity, alignment: .leading)

                TextField("음식 이름", text: $foodName)
                    .font(.title3)


                    .tint(.buttonPrimary)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 15))

                HStack {
                    Text("칼로리")
                        .font(.title3)
                    Text("(필수)")
                        .font(.caption)
                        .tint(.buttonPrimary)
                        .foregroundStyle(.blue)
                }
                .padding(.horizontal)
                .padding(.top, 15)
                .frame(maxWidth: .infinity, alignment: .leading)



                TextField("칼로리", text: $calories)
                    .font(.title3)
                    .tint(.buttonPrimary)
                    .padding()
                    .keyboardType(.numberPad)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 15))

                Divider()
                    .padding(.top)
            }
            .padding(.horizontal)


            List {
                if foods.isEmpty {
                    Text("음식을 추가해주세요.")
                        .foregroundStyle(.gray)
                } else {
                    ForEach(foods, id: \.id) { food in
                        HStack {
                            Text(food.name)
                            Spacer()
                            Text("\(food.calories) Kcal")
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
            }
            .listStyle(.plain)
            .padding(.vertical)
            .padding(.trailing, 16)
            .onAppear {
                updateFood()
            }

            Spacer()

            Button {
                guard !foodName.trimmingCharacters(in: .whitespaces).isEmpty else {
                    alertMessage = "음식 이름을 입력해주세요."
                    showAlert = true
                    return
                }

                guard let caloriesInt = Int(calories) else {
                    alertMessage = "칼로리는 숫자로 입력해주세요."
                    showAlert = true
                    return
                }

                guard caloriesInt > 0 else {
                    alertMessage = "정확한 값을 입력해주세요."
                    showAlert = true
                    return
                }

                saveFood()
            } label: {
                Text("저장")
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

        }
        .navigationTitle("\(mealType.rawValue) 메뉴 추가")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .tint(.primary)
                }
            }
        }
    }

    // 저장
    private func saveFood() {
        guard let calories = Int(calories) else {
            return
        }

        guard !foodName.isEmpty else {
            return
        }

        // 오늘 날짜의 MealRecord 가져오기 없으면 새로 생성
        let todayRecord = records.first(where: { $0.date == today }) ?? MealRecord(date: today, meals: [])

        // 해당 끼니 가져오기 없으면 새로 생성
        if let index = todayRecord.meals.firstIndex(where: { $0.type == mealType }) {
            // 있으면 기존 끼니에 음식 추가
            todayRecord.meals[index].foods.append(Food(name: foodName, calories: calories))
        } else {
            // 끼니가 없으면 새로 만들고 음식 추가
            let newMeal = Meal(type: mealType, foods: [Food(name: foodName, calories: calories)])
            todayRecord.meals.append(newMeal)
        }

        // 새로 만든 record 추가
        if !records.contains(where: { $0.date == today }) {
            context.insert(todayRecord)
        }

        // 초기화, 리스트 업데이트
        try? context.save()
        updateFood()
    }

    // 리스트 업데이트
    private func updateFood() {
        // 오늘 날짜에 MeaRecord 가져오기
        guard let todayRecord = records.first(where: { $0.date == today }) else {
            return foods = []
        }

        // 오늘 날짜에 MeaRecord에서 끼니 가져오기
        if let meal = todayRecord.meals.first(where: { $0.type == mealType }) {
            foods = meal.foods
        } else {
            foods = []
        }
    }

    // 삭제
    private func deleteFood(at offsets: IndexSet) {
        guard let todayRecord = records.first(where: { $0.date == today }) else {
			return
        }

        guard let meal = todayRecord.meals.first(where: { $0.type == mealType }) else {
            return
        }

        // 삭제할 Food 제거
        meal.foods.remove(atOffsets: offsets)

        // 저장
        try? context.save()

        // 리스트 업데이트
        updateFood()
    }
}

#Preview {
    AddMealView(mealType: .breakfast)
}
