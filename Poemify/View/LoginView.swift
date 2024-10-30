//
//  LoginView.swift
//  Poemify
//
//  Created by Artem Doloban on 30.10.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegistration = false
    @State private var showError = false
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var errorMessage = ""
    
    private let demoEmail = "test"
    private let demoPassword = "test"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: login) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(email.isEmpty || password.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(email.isEmpty || password.isEmpty)
                
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                    Button("Sign Up") {
                        showRegistration = true
                    }
                }
                .padding(.bottom, 20)
                .fullScreenCover(isPresented: $showRegistration) {
                    RegistrationView()
                }
            }
            .padding()
        }
    }
    
    private func login() {
        if email == demoEmail && password == demoPassword {
            showError = false
            isLoggedIn = true
        } else {
            showError = true
            errorMessage = "Invalid email or password. Please try again."
        }
    }
}

#Preview {
    LoginView()
}
