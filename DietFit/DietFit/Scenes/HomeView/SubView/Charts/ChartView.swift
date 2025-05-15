//
//  ChartView.swift
//  DietFit
//
//  Created by junil on 5/14/25.
//

import SwiftUI
import Charts
import SwiftData

struct ChartView: View {
    @Query(sort: \UserInfo.createdAt) private var user: [UserInfo]

    @State private var selectedRange: TimeRange = .week
    @State private var animationScale: CGFloat = 0
    @State private var selectedEntry: UserInfo? = nil
    @State private var touchLocation: CGPoint? = nil
    @State private var linePhase: CGFloat = 0

    enum TimeRange: String, CaseIterable, Identifiable {
        case week = "주"
        case month = "월"
        case year = "년"
        case all = "전체"

        var id: String { self.rawValue }
    }

    var filteredEntries: [UserInfo] {
        let calendar = Calendar.current
        let now = Date()

        switch selectedRange {
        case .week:
            guard let startDate = calendar.date(byAdding: .day, value: -6, to: now) else { return user }
            return user.filter { $0.createdAt >= calendar.startOfDay(for: startDate) }
        case .month:
            guard let startDate = calendar.date(byAdding: .month, value: -1, to: now) else { return user }
            return user.filter { $0.createdAt >= calendar.startOfDay(for: startDate) }
        case .year:
            guard let startDate = calendar.date(byAdding: .year, value: -1, to: now) else { return user }
            return user.filter { $0.createdAt >= calendar.startOfDay(for: startDate) }
        case .all:
            return user
        }
    }

    @ViewBuilder
    private var chartContent: some View {
        switch selectedRange {
        case .week:
            Chart(filteredEntries) { entry in
                if let bmiValue = entry.bmi {
                    BarMark(
                        x: .value("Date", entry.createdAt, unit: .day),
                        y: .value("BMI", bmiValue)
                    )
                    .foregroundStyle(by: .value("Type", "BMI"))
                    .position(by: .value("Type", "BMI"))
                }

                BarMark(
                    x: .value("Date", entry.createdAt, unit: .day),
                    y: .value("weight", entry.weight)
                )
                .foregroundStyle(by: .value("Type", "몸무게"))
                .position(by: .value("Type", "몸무게"))
            }
            .chartOverlay { proxy in
                GeometryReader { geo in
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Rectangle())
                        .onContinuousHover { phase in
                            switch phase {
                            case .active(let location):
                                touchLocation = location
                                updateSelectedEntry(proxy: proxy, location: location, geometry: geo)
                            default:
                                touchLocation = nil
                                selectedEntry = nil
                            }
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    touchLocation = value.location
                                    updateSelectedEntry(proxy: proxy, location: value.location, geometry: geo)
                                }
                                .onEnded { _ in

                                }
                        )
                }
            }
            .transition(.opacity)
            .scaleEffect(y: animationScale, anchor: UnitPoint.bottom)
             // Data changes within the chart (e.g. new bar)
            .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.2), value: filteredEntries)
            .onAppear {
                animationScale = 0
                DispatchQueue.main.async {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                        animationScale = 1
                    }
                }
            }
            .onChange(of: filteredEntries) {
                animationScale = 0
                DispatchQueue.main.async {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                        animationScale = 1
                    }
                }
            }

        default:
            Chart {
                ForEach(filteredEntries.indices.reversed(), id: \.self) { index in
                    let entry = filteredEntries[index]
                    if CGFloat(filteredEntries.count - 1 - index) <= linePhase * CGFloat(max(0, filteredEntries.count - 1)) {
                        if let bmiValue = entry.bmi {
                            LineMark(
                                x: .value("Date", entry.createdAt, unit: .day),
                                y: .value("BMI", bmiValue)
                            )
                            .foregroundStyle(by: .value("Type", "BMI"))
                            .interpolationMethod(.catmullRom)
                        }

                        LineMark(
                            x: .value("Date", entry.createdAt, unit: .day),
                            y: .value("weight", entry.weight)
                        )
                        .foregroundStyle(by: .value("Type", "몸무게"))
                        .interpolationMethod(.catmullRom)
                    }
                }
            }
            .chartOverlay { proxy in
                 GeometryReader { geo in
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Rectangle())
                        .onContinuousHover { phase in
                            switch phase {
                            case .active(let location):
                                touchLocation = location
                                updateSelectedEntry(proxy: proxy, location: location, geometry: geo)
                            default:
                                touchLocation = nil
                                selectedEntry = nil
                            }
                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    touchLocation = value.location
                                    updateSelectedEntry(proxy: proxy, location: value.location, geometry: geo)
                                }
                                .onEnded { _ in

                                }
                        )
                }
            }
            .transition(.opacity)
            .scaleEffect(x: animationScale, anchor: UnitPoint.leading)
            .onAppear {
                resetAndAnimateLineChart(animateScale: true)
            }
            .onChange(of: selectedRange) {
                resetAndAnimateLineChart(animateScale: true)
            }
            .onChange(of: filteredEntries) {
                resetAndAnimateLineChart(animateScale: false)
            }
        }
    }

    private func resetAndAnimateLineChart(animateScale: Bool) {
        linePhase = 0
        if animateScale { animationScale = 0 }

        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 1.0)) {
                linePhase = 1
            }
            if animateScale {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                    animationScale = 1
                }
            }
        }
    }

    private func updateSelectedEntry(proxy: ChartProxy, location: CGPoint, geometry: GeometryProxy) {
        let xPosition = location.x - geometry.frame(in: .local).origin.x
        if let date: Date = proxy.value(atX: xPosition) {
            var closestEntry: UserInfo? = nil
            var minDistance: TimeInterval = .greatestFiniteMagnitude

            let targetDateStartOfDay = Calendar.current.startOfDay(for: date)

            for entry in filteredEntries {

                let entryDateStartOfDay = Calendar.current.startOfDay(for: entry.createdAt)

                let timeWindow = selectedRange == .week ? (24*60*60 / 2) : (24*60*60 * 2)

                let distance = abs(entry.createdAt.timeIntervalSince(date))

                if Calendar.current.isDate(entryDateStartOfDay, inSameDayAs: targetDateStartOfDay) {
                     if distance < minDistance {
                         minDistance = distance
                         closestEntry = entry
                     } else if closestEntry == nil && distance < minDistance && Int(distance) < timeWindow {
                         minDistance = distance
                         closestEntry = entry
                     }
                }
            }
            selectedEntry = closestEntry
        } else {
            selectedEntry = nil
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 100) {
                Text("History")
                    .font(.title2)
                    .fontWeight(.semibold)

                Picker("기간", selection: $selectedRange) {
                    ForEach(TimeRange.allCases) { range in
                        Text(range.rawValue).tag(range)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.bottom)

            chartContent
                .frame(height: 200)
                .overlay(alignment: .topLeading) {
                    if let selectedEntry = selectedEntry, let touchLocation = touchLocation {
                        VStack(spacing: 0) {
                            VStack(alignment: .leading) {
                                Text("날짜: \(selectedEntry.createdAt, style: .date)")
                                if let bmiValue = selectedEntry.bmi {
                                    Text("BMI: \(String(format: "%.1f", bmiValue))")
                                } else {
                                    Text("BMI: N/A")
                                }
                                Text("몸무게: \(String(format: "%.1f", selectedEntry.weight))kg")
                            }
                            .padding(8)
                            .background(Color.secondary.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)

                            Rectangle()
                                .fill(Color.secondary.opacity(0.8))
                                .frame(width: 4, height: 20)
                                .clipShape(RoundedRectangle(cornerRadius: 2))
                        }
                        .position(x: max(40, min(touchLocation.x, UIScreen.main.bounds.width - 40)), y: touchLocation.y - 60)
                        .transition(.opacity.animation(.easeInOut(duration: 0.1)))
                    }
                }
            Spacer()
        }
    }
}


#Preview {
    ChartView()
}
