//
//  FitnessComposeView.swift
//  Dietfit
//
//  Created by Heejung Yang on 5/13/25.
//

import SwiftUI

struct FitnessComposeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isPresented: Bool = false

    @State var duration: Int = 30
    var body: some View {
        List {
            Section() {
                Text("109kcal 태웠어요")
            } header: {
                Text("Header")
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
                        dismiss()
                    } label: {
                        Text("가볍게")
                            .padding()
    //                        .frame(maxWidth: .infinity)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .tint(.white)
                    }
                    Button {
                        dismiss()
                    } label: {
                        Text("적당히")
                            .padding()
    //                        .frame(maxWidth: .infinity)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .tint(.white)
                    }
                    Button {
                        dismiss()
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
