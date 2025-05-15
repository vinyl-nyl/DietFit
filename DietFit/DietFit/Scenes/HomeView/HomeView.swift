//
//  HomeView.swift
//  DietFit
//
//  Created by junil on 5/12/25.
//

import Charts
import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \UserInfo.createdAt, order: .reverse) private var allUserInfo: [UserInfo]

    @State var showBmiSheet: Bool = false
    @State private var showWeightInput = false
    @State private var inputWeight: String = ""

    var currentTodayBmiDisplayString: String {
        if let todayEntry = allUserInfo.first(where: { Calendar.current.isDate($0.createdAt, inSameDayAs: Date()) }) {
            if let bmiValue = todayEntry.bmi {
                return String(format: "%.1f", bmiValue)
            } else {
                return "BMI 계산 오류"
            }
        } else {
            return "몸무게를 입력해주세요"
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TodayGoalsView()
                        .padding(.bottom, 40)

                    HStack {
                        VStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Text("Today's BMI")
                                    .fontWeight(.semibold)

                                VStack {
                                    Button {
                                        showBmiSheet = true
                                    } label: {
                                        Image(systemName: "info.circle")
                                            .font(.caption2)
                                    }
                                    .buttonStyle(.plain)
                                    Spacer()
                                }
                                .frame(height: 20)
                            }

                            Button {
                                if Double(currentTodayBmiDisplayString) == nil {
                                    showWeightInput = true
                                }
                            } label: {
                                if let bmiValue = Double(currentTodayBmiDisplayString) {
                                    Text(currentTodayBmiDisplayString)
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundStyle(BMITextColor(bmiData: bmiValue))
                                } else {
                                    Text(currentTodayBmiDisplayString)
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                        .sheet(isPresented: $showBmiSheet) {
                            HStack {
                                BMIPresentationView()
                            }
                            .padding(.horizontal, 20)
                            .presentationDetents([.medium])
                        }
                        .sheet(isPresented: $showWeightInput) {
                            VStack(alignment: .leading) {
                                InputWeightPresentationView(showWeightInput: $showWeightInput, inputWeight: $inputWeight)
                                Spacer()
                            }
                            .presentationDetents([.medium])
                        }
                        .onChange(of: showWeightInput) { oldValue, newValue in
                            if oldValue == true && newValue == false {
                                saveNewWeight()
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, 40)

                    ChartView()
                }
                
            }
            .navigationTitle("요약")
        }
        .modifier(StyleModifier())
        .padding(.horizontal, 20)
    }

    private func saveNewWeight() {
        guard let newWeightValue = Double(inputWeight), newWeightValue > 0 else {
            inputWeight = ""
            return
        }

        let nameToUse = allUserInfo.first?.name ?? "사용자"
        var heightToUse = allUserInfo.first?.height

        if heightToUse == nil || heightToUse! <= 0 {
            heightToUse = 160.0
        }

        let newUserInfo = UserInfo(name: nameToUse, height: heightToUse!, weight: newWeightValue, detail: nil, bmi: nil)

        modelContext.insert(newUserInfo)
        inputWeight = ""
    }
}

#Preview {
    HomeView()
}
