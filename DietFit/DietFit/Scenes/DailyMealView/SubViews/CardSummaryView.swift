//
//  CardSummaryView.swift
//  DietFit
//
//  Created by 박동언 on 5/14/25.
//

import SwiftUI

struct CardSummaryView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Text("오늘의 성과")
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 40)
        VStack {
            ZStack {
                Circle()
                    .inset(by: -30)
                    .rotation(.degrees(-180))
                    .trim(from: 0, to: 0.5)
                    .stroke(colorScheme == .dark ? Color(.systemGray4)  : Color(.systemGray6),
                            style: .init(lineWidth: 40, lineCap: .round))
                    .frame(width: 200, height: 200)
                    .offset(y: 50)
                
                Circle()
                    .inset(by: -30)
                    .rotation(.degrees(-180))
                    .trim(from: 0, to: 0.2)
                    .stroke(Color.buttonPrimary, style: .init(lineWidth: 40, lineCap: .round))
                    .frame(width: 200, height: 200)
                    .offset(y: 50)
                //                                        .animation(.easeInOut, value: percentage)
                
                VStack {
                    Text("500")
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.buttonPrimary)
                    Text("/ 2000 Kcal")
                        .font(.title3)
                }
                .offset(y: 25)
            }
        }
        
    }
}
