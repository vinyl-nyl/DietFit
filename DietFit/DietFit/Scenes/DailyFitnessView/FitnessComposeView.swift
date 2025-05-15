//
//  FitnessComposeView.swift
//  Dietfit
//
//  Created by Heejung Yang on 5/13/25.
//

import SwiftUI

struct FitnessComposeView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss

    @State var calories: Int = 109
    @State var duration: Int = 30
    @State var intensity: Int = 30

    @State private var isPresented: Bool = false


    var body: some View {
        List {

            Section() {
                TextField("칼로리 입력", value: $calories, format: .number)
            } header: {
                Text("운동 이름")
            }

            Section() {
                Stepper("\(duration) 분") {
                    duration+=10
                } onDecrement: {
                    duration-=10
                }

            } header: {
                Text("운동시간")
            }

            Section() {

                HStack {
                    Button {
                        intensity = 30
                    } label: {
                        Text("가볍게")
                            .padding()
    //                        .frame(maxWidth: .infinity)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .tint(.white)
                    }
                    Button {
                        intensity = 60
                    } label: {
                        Text("적당히")
                            .padding()
    //                        .frame(maxWidth: .infinity)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .tint(.white)
                    }
                    Button {
                        intensity = 90
                    } label: {
                        Text("격하게")
                            .padding()
    //                        .frame(maxWidth: .infinity)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .tint(.white)
                    }
                }
            } header: {
                Text("운동 강도")
            }
        }
        Button {
            let model = FitnessModel(area: "", exercise: "", calories: calories, duration: duration, intensity: intensity)

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
    FitnessComposeView()
}
