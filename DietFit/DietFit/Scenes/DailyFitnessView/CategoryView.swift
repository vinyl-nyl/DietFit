//
//  CategoryView.swift
//  DietFit
//
//  Created by Heejung Yang on 5/14/25.
//

import SwiftUI

class ViewModel: ObservableObject {
    var title: String = "Hello"
    @Published var list = [String]()
}

struct CategoryView: View {
    @Environment(\.dismissSearch) var dismissSearch
    @Environment(\.dismiss) var dismiss

    @State private var isPresentedModal: Bool = false

    @State var area: String
    @State var selected: [String] = []

    let areas = [ "Chest", "Back", "Leg", "Shoulder", "Triceps", "Biceps", "Core", "Forearm", "Cardio", "Sports"]

    @StateObject var vm = ViewModel()

    var body: some View {
        ScrollView(.horizontal) {
            HStack() {
                ForEach(areas, id: \.self) { area in
                    Button {
                        guard let value = areaToExercises[area] else { return }
                        self.area = area
                        if !vm.list.isEmpty {
                            vm.list.removeAll()
                        }
                        vm.list.append(contentsOf: value)
                    } label: {
                        Text(area)
                            .lineLimit(1)
                            .padding(10)
                            .background(area == self.area ? .gray : .clear)
                            .cornerRadius(20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.gray, lineWidth: 2)
                            }
                            .tint(area == self.area ? .white : .black)
                            .padding(5)

                    }

                }
            }
        }

        List {
            ForEach(areaToExercises[self.area] ?? [], id: \.self) { str in
                Button {
                    isPresentedModal = true
                } label: {
                    Text(str)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    Image(systemName: "plus.circle.fill")
                }
                .buttonStyle(.plain)


            }
        }
        .sheet(isPresented: $isPresentedModal) {
            FitnessComposeView()
                .presentationDetents([.height(600), .fraction(0.7)])
                .presentationCornerRadius(30)
                .presentationDragIndicator(.hidden)
                .presentationBackground(.ultraThickMaterial)
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
    CategoryView(area: "Back")
}
