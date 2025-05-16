//
//  ScrollCalendarView.swift
//  MySwiftUICatalog
//
//  Created by 박동언 on 5/12/25.
//

import SwiftUI

struct ScrollCalendarView: View {
    @Environment(\.colorScheme) private var colorScheme

    @State private var scrollTargetId: Date?

    @ObservedObject var mealVM: DailyMealViewModel

    private let calendar = Calendar.current
    private let today = Date().startOfDay // 시분초 정규화

    @State private var isExpanded = false


    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(mealVM.days, id: \.self) { date in
                    let isSelected = calendar.isDate(date, inSameDayAs: mealVM.selectedDate)
                    let weekdayString = date.dateFormat("E")
                    let dayString = date.dateFormat("d")

                    VStack {
                        Group {
                            Text(weekdayString)
                                .foregroundStyle(.buttonPrimary)
                            Button { // 선택한 날짜 가운데 정렬
                                mealVM.updateDays(from: date)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                    mealVM.selectedDate = date
                                    scrollTargetId = date
                                }
                            } label: {
                                Text(dayString)
                                    .font(.subheadline)
                            }
                            .buttonStyle(.plain)
                            .frame(width: 36, height: 36)
                            .foregroundStyle(isSelected ? .white : .buttonPrimary)
                            .background(isSelected ? .buttonPrimary : .clear)
                            .clipShape(Circle())
                            .id(date)
                        }
                        .font(.callout)
                        .bold()
                    }
                    .padding(.horizontal, 4)
                }
            }
            .padding()
            .background(colorScheme == .dark ? .black : .white)
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $scrollTargetId, anchor: .center)
        .onAppear { //SwiftUI 렌더링 완료 보장용
            // SwiftUI 뷰 렌더링 자체가 너무 느릴 때, 한 번 밀어도 부족해서 명시적 시간 지연이 필요할 때
            // 뷰 구조가 크거나, LazyVStack처럼 뷰 생성이 지연되는 경우 자주 씀
            
            // DispatchQueue.main.async 렌더 한 턴 밀기
            //  대부분의 상태 업데이트 문제에 충분
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                scrollTargetId = mealVM.selectedDate
            }
        }
    }
}

#Preview {
    ScrollCalendarView(mealVM: DailyMealViewModel())
}
