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
    @Environment(\.dismissSearch) var dismissSearch
    @Environment(\.dismiss) var dismiss

    let areas = [ "Chest", "Back", "Leg", "Shoulder", "Triceps", "Biceps", "Core", "Forearm", "Cardio", "Sports"]

    private var columns = [
        GridItem(.adaptive(minimum: 100, maximum: .infinity),
                 spacing: -5,
                 alignment: .topLeading)

    ]

    var body: some View {
        NavigationStack {
            SearchedView(searchText: searchText)
                .searchable(text: $searchText,
                            isPresented: $isPresented,
                            prompt: "운동명으로 검색")
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

private struct SearchedView: View {
    let searchText: String


    let items = ["a", "b", "c"]
    var filteredItems: [String] { items.filter { $0 == searchText.lowercased() } }


    @State private var isPresented = false
    @Environment(\.dismissSearch) private var dismissSearch


    var body: some View {
        if let item = filteredItems.first {
            Button("Details about \(item)") {
                isPresented = true
            }
            .sheet(isPresented: $isPresented) {
                NavigationStack {
                    //
                }
            }
        }
    }
}

#Preview {
    FitnessSearchView()
}
