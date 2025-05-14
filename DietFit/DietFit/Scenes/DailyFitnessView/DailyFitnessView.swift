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

        VStack() {

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
        }


        ScrollView {

            VStack {
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




        }


        }
        .background(Color(.systemGray6))
        .fullScreenCover(isPresented: $presentAddFitness, onDismiss: {

        }, content: {
            FitnessSearchView()
        })
    }

}

#Preview {
    DailyFitnessView()
}
