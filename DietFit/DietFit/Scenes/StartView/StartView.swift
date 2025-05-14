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

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Text("Welcome To DietFit!")
                    .font(.title)
                    .padding(20)
                
                TextField("이름", text: $name)
                    .textFieldStyle(.roundedBorder)

                TextField("키 (cm)", text: $height)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)

                TextField("몸무게 (kg)", text: $weight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
             
                Button {
                    if name.isEmpty || height.isEmpty || weight.isEmpty {
                        showAlert = true
                    } else if Double(height) == nil || Double(weight) == nil {
                        showAlert = true
                    } else {
                        showHome = true
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.buttonPrimary)
                        .frame(height: 50)
                        .overlay{
                            Text("Start dietFit")
                                .foregroundColor(.white)
                                .bold()
                        }
                }
                
                .padding(.horizontal)
                .alert("모든 정보를 올바르게 입력해주세요.", isPresented: $showAlert) {
                    Button("확인", role: .cancel) { }
                }
            }
            .padding()
            .navigationDestination(isPresented: $showHome) {
                HomeView()
            }
        }
    }
}


#Preview {
    StartView()
}
