//
//  UserInfo.swift
//  DietFit
//
//  Created by 권도현 on 5/14/25.
//


import SwiftUI
import SwiftData

struct StartView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme

    @State private var name: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var showAlert = false
    @State private var showContent = false

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
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .shadow(radius: 6, x: 0, y: 5)

                    Text("Start To Your Healthy Life!")
                        .font(.subheadline)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .shadow(radius: 3, x: 0, y: 5)
                        .opacity(0.6)

                    CustomTextField(title: "이름", systemName: "person.fill", value: $name)
                    CustomTextField(title: "키", systemName: "figure.stand", value: $height)
                    CustomTextField(title: "몸무게", systemName: "w.circle", value: $weight)

                    Button {
                        saveUserInfo()
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
            .navigationDestination(isPresented: $showContent) {
                ContentView()
            }
            .alert("모든 정보를 올바르게 입력해주세요.", isPresented: $showAlert) {
                Button {
                    
                } label: {
                    Text("확인")
                        .foregroundColor(.blue)
                }
            }

        }
    }

    private func saveUserInfo() {
        guard !name.isEmpty, let heightValue = Double(height), let weightValue = Double(weight) else {
            showAlert = true
            return
        }

        let newUser = UserInfo(name: name, height: heightValue, weight: weightValue, bmi: nil)
        modelContext.insert(newUser)
        showContent = true
    }
}


#Preview {
    StartView()
}

