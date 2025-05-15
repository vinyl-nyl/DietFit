//
//  CategoryView.swift
//  DietFit
//
//  Created by Heejung Yang on 5/14/25.
//

import SwiftUI
import SwiftData

class ViewModel: ObservableObject {
    var title: String = "Hello"
    @Published var selected: String = ""
}

struct CategoryView: View {
    @State private var isPresentedModal: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var area: String = ""
    @State var count: Int = 0

    let areas = [ "Chest", "Back", "Leg", "Shoulder", "Triceps", "Biceps", "Core", "Forearm", "Cardio", "Sports"]

    @StateObject var vm = ViewModel()

    var body: some View {
        HStack {
            Text("Categories")
                .padding(.leading)
                .font(.title3)
                .bold()
                .padding(.trailing, 10)

            ScrollView(.horizontal) {
                HStack() {
                    ForEach(areas, id: \.self) { area in
                        Button {
                            self.area = area
                        } label: {
                            Text(area)
                                .lineLimit(1)
                                .padding(10)
                                .background(area == self.area ? .gray : .clear)
                                .cornerRadius(20)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(.systemGray6), lineWidth: 2)
                                }
                                .tint(area == self.area ? .white : .gray)
                                .padding(5)

                        }

                    }
                }
            }
        }

        List {
            ForEach(areaToExercises[self.area] ?? [], id: \.self) { exercise in
                Button {
                    vm.selected = exercise
                    isPresentedModal = true
                } label: {
                    Text(exercise)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    Image(systemName: "plus.circle.fill")
                }
                .buttonStyle(.plain)
                .tag(exercise)


            }
        }
        .sheet(isPresented: $isPresentedModal) {
            FitnessComposeView(area: area, exercise: vm.selected)
                .presentationDetents([.height(600), .fraction(0.7)])
                .presentationCornerRadius(30)
                .presentationDragIndicator(.hidden)
//                .presentationBackground(.ultraThickMaterial) 
        }

    }
}

extension CategoryView {
    var areaToExercises: [String: [String]] {
        return [
            "Chest": [
                "Bench Press",
                "Incline Dumbbell Press",
                "Push-ups",
                "Chest Fly",
                "Cable Crossover"
            ],
            "Back": [
                "Deadlift",
                "Pull-ups",
                "Bent-over Row",
                "Lat Pulldown",
                "Seated Row"
            ],
            "Leg": [
                "Squats",
                "Lunges",
                "Leg Press",
                "Leg Curl",
                "Calf Raise"
            ],
            "Shoulder": [
                "Shoulder Press",
                "Lateral Raise",
                "Front Raise",
                "Upright Row",
                "Arnold Press"
            ],
            "Triceps": [
                "Tricep Pushdown",
                "Skull Crushers",
                "Dips",
                "Overhead Tricep Extension",
                "Close Grip Bench Press"
            ],
            "Biceps": [
                "Barbell Curl",
                "Hammer Curl",
                "Concentration Curl",
                "Preacher Curl",
                "Cable Curl"
            ],
            "Core": [
                "Plank",
                "Sit-ups",
                "Russian Twist",
                "Leg Raises",
                "Bicycle Crunch"
            ],
            "Forearm": [
                "Wrist Curl",
                "Reverse Curl",
                "Farmer’s Carry",
                "Grip Squeeze",
                "Bar Hang"
            ],
            "Cardio": [
                "Running",
                "Jump Rope",
                "Cycling",
                "Rowing",
                "Stair Climber"
            ],
            "Sports": [
                "Basketball",
                "Soccer",
                "Swimming",
                "Tennis",
                "Boxing"
            ]
        ]
    }

}


#Preview {
//    CategoryView(area: "Back")
}
