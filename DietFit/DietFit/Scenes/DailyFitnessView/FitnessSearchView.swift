//
//  FitnessSearchView.swift
//  DietFit
//
//  Created by Heejung Yang on 5/14/25.
//

import SwiftUI

struct FitnessSearchView: View {
    @State private var searchText: String = ""
    @State private var isPresented: Bool = false
    @State private var isPresentedModal: Bool = false
    
    @Environment(\.dismiss) var dismiss

    let areas = [ "Chest", "Back", "Leg", "Shoulder", "Triceps", "Biceps", "Core", "Forearm", "Cardio", "Sports"]

    private var columns = [
        GridItem(.adaptive(minimum: 100, maximum: .infinity),
                 spacing: -5,
                 alignment: .topLeading)

    ]

    var body: some View {
        NavigationStack {
            VStack {

                Text("Categories")
                    .padding(.leading)
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                LazyVGrid(columns: columns) {
                    ForEach(areas, id: \.self) { area in

                        NavigationLink {
                            CategoryView(area: area)
                        } label: {
                            Text(area)
                                .lineLimit(1)
                                .frame(width: 70, height: 20, alignment: .center)
                                .padding(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.gray, lineWidth: 2)
                                }
                                .tint(.black)
                                .padding(5)
                        }

                    }
                }
            
            }
            .padding()
            .searchable(text: $searchText, isPresented: $isPresentedModal, placement: .toolbar, prompt: "운동명으로 검색")
            .toolbar {
                ToolbarItem {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .bold()
                    }
                }
            }

            Spacer()
        }
    }
}


#Preview {
    FitnessSearchView()
}
