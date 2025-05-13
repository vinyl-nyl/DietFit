//
//  DailyFitnessView.swift
//  Dietfit
//
//  Created by Heejung Yang on 5/13/25.
//

import SwiftUI

struct DailyFitnessView: View {
    @Environment(\.colorScheme) private var colorScheme

    @State var presentAddFitness: Bool = false

    var body: some View {
        Text("운동을 기록해주세요.")
        VStack(alignment: .listRowSeparatorTrailing) {

            Button {
                presentAddFitness = true
            } label: {

                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .tint(.white)
                    .bold()
                    .background(Color("ButtonPrimary"))
                    .padding(15)
                    .background(Color("ButtonPrimary"))
                    .clipShape(Capsule())

            }

        }
    }
}

#Preview {
    DailyFitnessView()
}
