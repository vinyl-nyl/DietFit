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

    let area: String
    let exercise: String

    @State var calories: Int = 0
    @State var duration: Int = 30
    @State private var intensity: String = "적당히"
    @State private var isPresented: Bool = false

    @StateObject var excerciesList = ViewModel()


    var body: some View {
        List {

            Section() {
                TextField("칼로리 입력", value: $calories, format: .number)
            } header: {
                Text(exercise)
                    .font(.title3)
            }

            Section() {
                Stepper("\(duration) 분") {
                    duration+=10
                } onDecrement: {
                    duration-=10
                }

            } header: {
                Text("운동시간")
                    .font(.headline)
            }

            Section() {

                HStack {
                    Button {
                        intensity = "가볍게"
                    } label: {
                        Text("가볍게")
                            .padding()
//                            .background(intensity == "가볍게" ? .green : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .tint(.white)
                    }
                    Button {
                        intensity = "적당히"
                    } label: {
                        Text("적당히")
                            .padding()
//                            .background(intensity == "적당히" ? .green : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .tint(.white)
                    }
                    Button {
                        intensity = "격하게"
                    } label: {
                        Text("격하게")
                            .padding()
//                            .background(intensity == "격하게" ? .green : .gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .tint(.white)
                    }
                }
            } header: {
                Text("운동 강도")
                    .font(.headline)
            }
        }
        Button {
            let model = FitnessModel(name: "Kim", area: area, exercise: exercise, calories: calories, duration: duration, intensity: "가볍게")

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
    FitnessComposeView(area: "Chest", exercise: "Push-ups")
}
