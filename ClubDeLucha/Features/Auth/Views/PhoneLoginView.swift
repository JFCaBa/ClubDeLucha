//
//  PhoneLoginView.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//

import SwiftUI

struct PhoneLoginView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @StateObject private var viewModel: PhoneLoginViewModel
    @State private var phoneNumber = ""
    
    init(viewModel: PhoneLoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Image("club_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.6)
                    .padding(.top, 50)
                
                Text("Enter your phone number".localised)
                    .font(.title2)
                    .fontWeight(.medium)
                
                TextField("Phone Number".localised, text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .textFieldStyle(CustomTextFieldStyle())
                    .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    viewModel.login(phoneNumber: phoneNumber)
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Login")
                            .font(.headline)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(viewModel.isLoading ? Color.blue.opacity(0.5) : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(25)
                .disabled(viewModel.isLoading)
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .onChange(of: viewModel.isAuthenticated, { oldValue, newValue in
                if newValue {
                    coordinator.authenticationState = .authenticated
                }
            })
        }
        .alert("Error".localised, isPresented: Binding(
            get: { viewModel.error != nil },
            set: { _ in viewModel.error = nil }
        )) {
            Button("OK".localised, role: .cancel) {}
        } message: {
            Text(viewModel.error ?? "")
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height: 50)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}

#Preview {
    PhoneLoginView(viewModel: PhoneLoginViewModel(authService: AuthService()))
        .environmentObject(AppCoordinator())
}
