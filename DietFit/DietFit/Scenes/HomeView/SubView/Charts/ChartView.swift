import SwiftUI
import Charts

struct ChartView: View {
    @State private var selectedRange: TimeRange = .week
    @State private var bmiEntries: [BMIEntry] = []
    @State private var animationScale: CGFloat = 0
    @State private var selectedEntry: BMIEntry? = nil
    @State private var touchLocation: CGPoint? = nil

    enum TimeRange: String, CaseIterable, Identifiable {
        case week = "주"
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
        default: // .year, .all
            Chart(filteredEntries) { entry in
                LineMark(
                    x: .value("Date", entry.date, unit: .day),
                    y: .value("BMI", entry.BMI)
                )
                .foregroundStyle(by: .value("Type", "BMI"))
                .interpolationMethod(.catmullRom)

                LineMark(
                    x: .value("Date", entry.date, unit: .day),
                    y: .value("weight", entry.weight)
                )
                .foregroundStyle(by: .value("Type", "몸무게"))
                .interpolationMethod(.catmullRom)
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
            .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.2), value: filteredEntries)
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
            HStack(spacing: 130) {
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
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5)) {
                        animationScale = 1
                    }
                }
                .onChange(of: filteredEntries) {
                    animationScale = 0
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.9)) {
                        animationScale = 1
                    }
                }
                .overlay(alignment: .topLeading) {
                    if let selectedEntry = selectedEntry, let touchLocation = touchLocation {
                        VStack(alignment: .leading) {
                            Text("날짜: \(selectedEntry.date, style: .date)")
                            Text("BMI: \(String(format: "%.1f", selectedEntry.BMI))")
                            Text("몸무게: \(String(format: "%.1f", selectedEntry.weight))kg")
                        }
                        .padding(8)
                        .background(Color.secondary.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .offset(x: touchLocation.x, y: touchLocation.y - 60) // Adjust offset as needed
                        .shadow(radius: 2)
                    }
                }

            Spacer()
        }
    }
}

#Preview {
    ChartView()
}
