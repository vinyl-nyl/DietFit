//
//  FitnessComposeView.swift
//  Dietfit
//
//  Created by Heejung Yang on 5/13/25.
//

import SwiftUI
import SwiftData

struct FitnessComposeView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss

    let selected: Date
    let area: String
    let exercise: String

    @State var calories: Int? = nil
    @State var duration: Int = 30
    @State private var intensity: String = ""

    @State private var isPresented: Bool = false

    @StateObject var excerciesList = ViewModel()


    var body: some View {
        List {

            Section() {
                TextField("칼로리 입력", value: $calories, format: .number)
            } header: {
                Text(exercise)
                    .font(.headline)
            }

            Section() {
                Stepper("\(duration) 분") {
                    duration+=10
                } onDecrement: {
                    duration-=10
                }

            } header: {
                Text("운동시간")
                    .font(.subheadline)
            }

            Section() {
                TextField("가볍게, 적당히, 격하게 중에서 입력", text: $intensity)
            } header: {
                Text("운동강도")
                    .font(.subheadline)
            }


        }
        Button {
            let model = FitnessModel(name: "Kim", insertDate: selected, area: area, exercise: exercise, calories: calories ?? 0, duration: duration, intensity: intensity)

            context.insert(model)

            dismiss()
        } label: {
            Text("Done")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .tint(.white)
        }
        .padding()



    }
}


#Preview {
//    FitnessComposeView(area: "Chest", exercise: "Push-ups")
}
