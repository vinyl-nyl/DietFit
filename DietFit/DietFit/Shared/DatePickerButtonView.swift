//
//  DatePickerButton.swift
//  DietFit
//
//  Created by 박동언 on 5/14/25.
//

import SwiftUI

struct DatePickerButtonView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @ObservedObject var mealVM: DailyMealViewModel

    @State private var presentCalendar = false

    var body: some View {
        Button {
            presentCalendar = true
        } label: {
            Text(mealVM.selectedDate.dateFormat("M.dd (E)"))
                .font(.title3)
                .bold()
            Image(systemName: "arrowtriangle.down.fill")
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
        .sheet(isPresented: $presentCalendar) {
            VStack {
                DatePicker("date", selection: $mealVM.selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .tint(Color.buttonPrimary)
                    .onChange(of: mealVM.selectedDate) { old, new in
                        mealVM.updateDays(from: new)
                        presentCalendar = false
                    }
            }
            .presentationDetents(horizontalSizeClass == .compact ? [.fraction(0.6)] : [.large])
            .presentationDragIndicator(.visible)
        }
    }
}


#Preview {
    DatePickerButtonView(mealVM: DailyMealViewModel())
}
