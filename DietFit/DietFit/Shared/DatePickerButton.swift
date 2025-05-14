//
//  DatePickerButton.swift
//  DietFit
//
//  Created by 박동언 on 5/14/25.
//

import SwiftUI

struct DatePickerButton: View {
    @State private var presentCalendar = false

    @Binding var selectedDate: Date

    var body: some View {
        Button {
            presentCalendar = true
        } label: {
            Text(dateFormat(selectedDate))
                .font(.title3)
                .bold()
            Image(systemName: "arrowtriangle.down.fill")
        }
        .sheet(isPresented: $presentCalendar) {
            VStack {
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .tint(Color.buttonPrimary)
                    .padding()
                    .onChange(of: selectedDate) {
                        presentCalendar = false
                    }
            }
            .presentationDetents([.fraction(0.6)])
            .presentationDragIndicator(.visible)
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}
