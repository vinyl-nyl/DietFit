//
//  DailyFitnessView.swift
//  Dietfit
//
//  Created by Heejung Yang on 5/13/25.
//

import SwiftUI

struct DailyFitnessView: View {
    @Environment(\.colorScheme) private var colorScheme

    @StateObject private var mealVM = DailyMealViewModel()
    
    @State private var presentCalendar = false
    @State var presentAddFitness: Bool = false
    @State private var selectDate = Date()

    var body: some View {

        NavigationStack {
            VStack(spacing: 0) {
                // 상단 바 - 날짜 선택, 유저 아이콘
                VStack(spacing: 0) {
                    HStack {
                        DatePickerButtonView(mealVM: mealVM)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    ScrollCalendarView(mealVM: mealVM)
                }

                ScrollView {
                    VStack(spacing: 16) {
                
                        VStack(spacing: 16) {
                            Text("운동 기록하기")
                                .font(.title3)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()


                            Button {
                                presentAddFitness = true
                            } label: {

                                VStack(alignment: .center, spacing: 16) {
                                    HStack(spacing: 25) {
                                        Image(systemName: "plus")
                                    }
                                    .font(.title)
                                    .imageScale(.large)
                                }
                                .dynamicTypeSize(.large)

                            }
                            .buttonStyle(.plain)
                            .frame(width: 300, height: 120)
                            .background(Color(.systemGray6))
                            .modifier(CardStyleModifier())
                            .padding()

                        }
                        .frame(width: 360, height: 280)
                        .modifier(CardStyleModifier())
                        .padding()



                        // 메모
                        VStack(spacing: 16) {
                            CardMemoView(mealVM: mealVM)
                                .buttonStyle(.plain)
                        }
                        .modifier(CardStyleModifier())
                        .padding(.horizontal, 20)



                    }
                    .padding(.top)

                    .frame(maxWidth: .infinity)
                }
                .scrollIndicators(.hidden)
                .background(colorScheme == .dark ? .black : Color(.systemGray6))
                //                .navigationDestination(for: MealType.self) { type in
                //                    AddMealView(type: type)
                //                }
            }
            .fullScreenCover(isPresented: $presentAddFitness, onDismiss: {

            }, content: {
                FitnessSearchView()
            })

        }
    }

}

#Preview {
    DailyFitnessView()
}
