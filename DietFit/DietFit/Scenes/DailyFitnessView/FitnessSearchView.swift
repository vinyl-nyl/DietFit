//
//  FitnessSearchView.swift
//  DietFit
//
//  Created by Heejung Yang on 5/14/25.
//

import SwiftUI

enum FitnessType: String, CaseIterable, Identifiable {
    case 근력운동 = "근력운동"
    case 유산소 = "유산소"
    case 요가필라테스 = "요가/필라테스"

    var id: Self { return self }
}

struct FitnessSearchView: View {
    @State private var searchText: String = ""
    @State private var isPresented: Bool = false
    @Environment(\.dismissSearch) var dismissSearch
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            HStack {
                SearchedView(searchText: searchText)
                    .searchable(text: $searchText,
                                isPresented: $isPresented,
                                prompt: "운동명으로 검색")
            }

            Section() {
                HStack {
                    ForEach(FitnessType.allCases) { item in
                        NavigationLink {

                        } label: {
                            Button {

                            } label: {

                                Text(item.rawValue)
                                    .padding(5)
                                    .background(.green)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .tint(.white)
                            }

                        }

                    }

                }

            } header: {
                Text("카테고리")
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
