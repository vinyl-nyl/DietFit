//
//  MemoComposeView.swift
//  DietFit
//
//  Created by 박동언 on 5/14/25.
//

import SwiftUI
import SwiftData

struct ComposeMemoView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Query private var mealRecord: [MealRecord]

    @FocusState private var isFocused: Bool

    @ObservedObject var mealVM: DailyMealViewModel

    @State private var mealMemo: String = ""
    @State private var fitnessMemo: String = ""

    var body: some View {
        Divider()
            .padding(.horizontal)

        VStack(spacing: 16) {
            ForEach (MemoType.allCases, id: \.self) { type in
                HStack {
                    Image(systemName: type.icon)

                    Text(type.rawValue)
                        .font(.title3)

                    Spacer()
                }
                .padding(.top, 12)

                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)

                    if type == .meal {
                        TextEditor(text: $mealMemo)
                            .tint(.buttonPrimary)
                            .focused($isFocused)
                        	// background(.clear)해도 스크롤 가능 영역에 시스템 색상이 그대로 남아있음
                        	// 뷰 내부에 스크롤 가능한 영역 표시 여부 지정
                            .scrollContentBackground(.hidden)
                            .padding(8)
                    } else {
                        TextEditor(text: $fitnessMemo)
                            .tint(.buttonPrimary)
                            .focused($isFocused)

                            .scrollContentBackground(.hidden)
                            .padding(8)
                    }

                    if mealMemo.isEmpty && !isFocused {
                        Text("식단 일지를 기록하세요.")
                            .foregroundStyle(.secondary)
                            .padding()
                    }
                }
                .frame(height: 180)
            }
            
            Spacer()
        }
        .modifier(MemoStyleModifier())
        .onAppear {
            if let existing = mealRecord.first(where: { $0.date == mealVM.selectedDate.startOfDay }) {
                mealMemo = existing.memo ?? ""
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .tint(.primary)
                }
            }
            ToolbarItem(placement: .principal) {
                Text(mealVM.selectedDate.dateFormat("M월 d일 E"))
                    .font(.title3)
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if let record = mealRecord.first(where: { $0.date == mealVM.selectedDate }) {
                        record.memo = mealMemo
                    } else {
                        let newMemo = MealRecord(date: mealVM.selectedDate, meals: [], memo: mealMemo)
                        context.insert(newMemo)
                    }
                    dismiss()
                } label: {
                    Text("저장")
                        .font(.title3)
                        .foregroundStyle(Color.buttonPrimary)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    ComposeMemoView(mealVM: DailyMealViewModel())
}
