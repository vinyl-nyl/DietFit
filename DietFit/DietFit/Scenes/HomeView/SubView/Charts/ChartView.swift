//
//  ChartView.swift
//  DietFit
//
//  Created by junil on 5/14/25.
//

import SwiftUI
import Charts

struct ChartView: View {
    @State private var selectedRange: TimeRange = .week
    @State private var bmiEntries: [BMIEntry] = []
    @State private var animationScale: CGFloat = 0
    @State private var selectedEntry: BMIEntry? = nil
    @State private var touchLocation: CGPoint? = nil
    @State private var linePhase: CGFloat = 0

    enum TimeRange: String, CaseIterable, Identifiable {
        case week = "주"
        case month = "월"
        case year = "년"
        case all = "전체"

        var id: String { self.rawValue }
    }

    var filteredEntries: [BMIEntry] {
        let calendar = Calendar.current
        let now = Date()

        switch selectedRange {
        case .week:
            guard let startDate = calendar.date(byAdding: .day, value: -6, to: now) else { return bmiEntries }
            return bmiEntries.filter { $0.date >= startDate }
        case .month:
            guard let startDate = calendar.date(byAdding: .month, value: -1, to: now) else { return bmiEntries }
            return bmiEntries.filter { $0.date >= startDate }
        case .year:
            guard let startDate = calendar.date(byAdding: .year, value: -1, to: now) else { return bmiEntries }
            return bmiEntries.filter { $0.date >= startDate }
        case .all:
            return bmiEntries
        }
    }

    @ViewBuilder
    private var chartContent: some View {
        switch selectedRange {
        case .week:
            Chart(filteredEntries) { entry in
                BarMark(
                    x: .value("Date", entry.date, unit: .day),
                    y: .value("BMI", entry.BMI)
                )
                .foregroundStyle(by: .value("Type", "BMI"))
                .position(by: .value("Type", "BMI"))

                BarMark(
                    x: .value("Date", entry.date, unit: .day),
                    y: .value("weight", entry.weight)
                )
                .foregroundStyle(by: .value("Type", "몸무게"))
                .position(by: .value("Type", "몸무게"))
            }
            .chartOverlay { proxy in
                GeometryReader { geo in
                    Rectangle()
                        .fill(.clear)
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
                            DragGesture()
                                .onChanged { value in
                                    touchLocation = value.location
                                    updateSelectedEntry(proxy: proxy, location: value.location, geometry: geo)
                                }
                                .onEnded { _ in
                                    touchLocation = nil
                                    selectedEntry = nil
                                }
                        )
                }
            }
            .transition(.opacity)
            .scaleEffect(y: animationScale, anchor: UnitPoint.bottom)
            .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.2), value: filteredEntries)
        default:
            Chart {
                ForEach(filteredEntries.indices.reversed(), id: \.self) { index in
                    if CGFloat(filteredEntries.count - 1 - index) <= linePhase * CGFloat(filteredEntries.count - 1) {
                        LineMark(
                            x: .value("Date", filteredEntries[index].date, unit: .day),
                            y: .value("BMI", filteredEntries[index].BMI)
                        )
                        .foregroundStyle(by: .value("Type", "BMI"))
                        .interpolationMethod(.catmullRom)

                        LineMark(
                            x: .value("Date", filteredEntries[index].date, unit: .day),
                            y: .value("weight", filteredEntries[index].weight)
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
                            DragGesture()
                                .onChanged { value in
                                    touchLocation = value.location
                                    updateSelectedEntry(proxy: proxy, location: value.location, geometry: geo)
                                }
                                .onEnded { _ in
                                    touchLocation = nil
                                    selectedEntry = nil
                                }
                        )
                }
            }
            .transition(.opacity)
            .scaleEffect(x: animationScale, anchor: UnitPoint.leading)
            .onAppear {
                withAnimation(.easeInOut) {
                    linePhase = 1
                }
            }
            .onChange(of: selectedRange) { _, _ in
                linePhase = 0
                withAnimation(.easeInOut) {
                    linePhase = 1

                }
            }
        }
    }

    private func updateSelectedEntry(proxy: ChartProxy, location: CGPoint, geometry: GeometryProxy) {
        let xPosition = location.x - geometry.frame(in: .local).origin.x
        if let date: Date = proxy.value(atX: xPosition) {
            var closestEntry: BMIEntry? = nil
            var minDistance: TimeInterval? = nil

            for entry in filteredEntries {
                let distance = abs(entry.date.timeIntervalSince(date))
                if minDistance == nil || distance < minDistance! {
                    minDistance = distance
                    closestEntry = entry
                }
            }
            selectedEntry = closestEntry
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
                .onAppear {
                    bmiEntries = loadBMIData()
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                        animationScale = 1
                    }
                }
                .onChange(of: filteredEntries) { _, _ in
                    animationScale = 0
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                        animationScale = 1
                    }
                }
                .overlay(alignment: .topLeading) {
                    if let selectedEntry = selectedEntry, let touchLocation = touchLocation {
                        VStack(spacing: 0) {
                            VStack(alignment: .leading) {
                                Text("날짜: \(selectedEntry.date, style: .date)")
                                Text("BMI: \(String(format: "%.1f", selectedEntry.BMI))")
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
                                .cornerRadius(2)
                        }
                        .offset(x: touchLocation.x - 80, y: touchLocation.y - 105)
                    }
                }

            Spacer()
        }
    }
}

#Preview {
    ChartView()
}
