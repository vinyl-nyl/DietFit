//
//  DailyFitnessView.swift
//  Dietfit
//
//  Created by Heejung Yang on 5/13/25.
//

import SwiftUI

struct DailyFitnessView: View {
    @Environment(\.colorScheme) private var colorScheme

    @State private var presentCalendar = false
    @State var presentAddFitness: Bool = false
    @State private var selectDate = Date()

    var body: some View {

        VStack(alignment: .center) {

            HStack {
                Button {
                    presentCalendar = true
                } label: {
                    Text(dateFormat(selectDate))
                        .font(.title3)
                        .bold()
                    Image(systemName: "arrowtriangle.down.fill")
                }
                .sheet(isPresented: $presentCalendar) {
                    VStack {
                        DatePicker("Select a date", selection: $selectDate, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .tint(Color.buttonPrimary)
                            .padding()
                            .onChange(of: selectDate) {
                                presentCalendar = false
                            }
                    }
                    .presentationDetents([.fraction(0.6)])
                    .presentationDragIndicator(.visible)
                }
                .buttonStyle(.plain)
                .padding(.horizontal)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollCalendarView(selectDate: $selectDate)

            VStack(spacing: 0) {
                Text("운동을 기록해주세요.")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)


                Button {
                    presentAddFitness = true
                } label: {

                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .tint(.gray)
                        .bold()
                        .padding(15)
                        .clipShape(Capsule())

                }

            }
            .frame(width: 360, height: 360)
            .modifier(CardStyleModifier())


            Spacer()

        }
        .fullScreenCover(isPresented: $presentAddFitness, onDismiss: {

        }, content: {
            FitnessSearchView()
        })
    }

}

#Preview {
    DailyFitnessView()
}
