//
//  UserInfo.swift
//  DietFit
//
//  Created by 권도현 on 5/14/25.
//


import SwiftUI

struct StartView: View {
    @State private var name: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var showAlert = false
    @State private var showHome = false
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 20) {
                    Image(systemName: "heart.circle.fill")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 120, height: 120)
                           .foregroundColor(Color.buttonPrimary)
                    
                    
                    Text("Welcome To DietFit!")
                        .font(.title)
                        .foregroundColor(colorScheme == .dark ? Color.white : .black)
                        .shadow(radius: 6, x: 0, y: 5)
                    Text("Start To Your Healthy Life!")
                        .font(.subheadline)
                        .foregroundColor(colorScheme == .dark ? Color.white : .black)
                        .shadow(radius: 3, x: 0, y: 5)
                        .opacity(0.6)

                    CustomTextField(title: "이름", systemName: "person.fill", value: $name)
                    
                    CustomTextField(title: "키", systemName: "figure.stand", value: $height)

                    CustomTextField(title: "몸무게", systemName: "w.circle", value: $weight)

                    Button {
                        if name.isEmpty || height.isEmpty || weight.isEmpty {
                            showAlert = true
                        } else if Double(height) == nil || Double(weight) == nil {
                            showAlert = true
                        } else {
                            showHome = true
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.buttonPrimary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .overlay {
                                Text("Start dietFit")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                    }
                    .padding(.horizontal)

                }
                .padding()
            }
            .navigationDestination(isPresented: $showHome) {
                HomeView()
            }
            .alert("모든 정보를 올바르게 입력해주세요.", isPresented: $showAlert) {
                Button {
                    // 확인 버튼 동작
                } label: {
                    Text("확인")
                        .foregroundColor(.blue)
                        .font(.body)
                }
                .buttonStyle(.bordered)
                .controlSize(.regular)
            }
        }
    }
}

#Preview {
    StartView()
}

