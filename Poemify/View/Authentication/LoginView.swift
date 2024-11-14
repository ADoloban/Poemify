//
//  LoginView.swift
//  Poemify
//
//  Created by Artem Doloban on 30.10.2024.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    @Binding var showLoginView: Bool
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("01204E"), Color("257180")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Login")
                    .foregroundStyle(Color("EBE3D5"))
                    .font(.system(size: 80, weight: .bold, design: .rounded))
                    .padding(.top, 40)
                
                VStack(spacing: 10) {
                    TextField("", text: $email)
                        .foregroundStyle(Color("EBE3D5"))
                        .textFieldStyle(.plain)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .placeholder(when: email.isEmpty) {
                            Text("Email")
                                .foregroundStyle(Color("EBE3D5"))
                                .bold()
                        }
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    Rectangle()
                        .frame(width: 350, height: 2)
                        .foregroundStyle(Color("EBE3D5"))
                }
                .padding(.top, 40)
                
                VStack(spacing: 10) {
                    SecureField("", text: $password)
                        .foregroundStyle(Color("EBE3D5"))
                        .textFieldStyle(.plain)
                        .autocapitalization(.none)
                        .placeholder(when: password.isEmpty) {
                            Text("Password")
                                .foregroundStyle(Color("EBE3D5"))
                                .bold()
                        }
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                    
                    Rectangle()
                        .frame(width: 350, height: 2)
                        .foregroundStyle(Color("EBE3D5"))
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(Color("C7253E"))
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Button(action: login) {
                    Text("Login")
                        .frame(width: 150)
                        .padding(10)
                        .background(email.isEmpty || password.isEmpty ? Color("5F6F65") : Color("FD8B51"))
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .cornerRadius(20)
                        .foregroundStyle(Color("EBE3D5"))
                }
                .disabled(email.isEmpty || password.isEmpty)
                
                Spacer()
                
                HStack() {
                    Text("Don't have an account?")
                        .foregroundStyle(Color("EBE3D5"))
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Sign Up")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .padding(10)
                            .foregroundStyle(Color("EBE3D5"))
                    }
                    .background(Color("FD8B51"))
                    .cornerRadius(20)
                }
                .padding(.bottom, 20)
                
            }
            .frame(width: 350)
        }
        
    }
    
    private func login() {
        isLoading = true
        errorMessage = nil
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            isLoading = false
            if let error = error {
                errorMessage = error.localizedDescription
                print(error)
            } else {
                isLoggedIn = true
                showLoginView = false
            }
        }
    }
}

#Preview {
    LoginView(showLoginView: .constant(true))
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
    
}
