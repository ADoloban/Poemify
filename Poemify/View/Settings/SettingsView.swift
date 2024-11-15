//
//  SettingsView.swift
//  Poemify
//
//  Created by Artem Doloban on 11.10.2024.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("isLoggedIn") private var isLoggedIn = true
    
    @State private var showModal = false
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var showAlert = false
    @State private var errorMessage: String?
    @State private var alertTitle = "Message"
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("01204E"), Color("257180")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack {
                    ZStack {
                        Text("Settings")
                            .font(.title)
                            .foregroundStyle(Color("C6EBC5"))
                            .bold()
                        
                        HStack {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(Color("C6EBC5"))
                            }
                            Spacer()
                        }
                    }
                    .padding(.bottom, 10)
                }
                
                Button(action: {
                    showModal = true
                }) {
                    Text("Update Password")
                        .frame(maxWidth: 200)
                        .padding()
                        .font(.system(size: 20, weight: .bold))
                        .background(Color("FD8B51"))
                        .foregroundStyle(Color("EBE3D5"))
                        .cornerRadius(20)
                }
                
                Button(action: logout) {
                    Text("Logout")
                        .frame(maxWidth: 200)
                        .padding()
                        .font(.system(size: 20, weight: .bold))
                        .background(Color("C7253E"))
                        .foregroundColor(Color("EBE3D5"))
                        .cornerRadius(20)
                }
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
            .overlay {
                if showModal {
                    ChangePasswordModalView(
                        isPresented: $showModal,
                        currentPassword: $currentPassword,
                        newPassword: $newPassword,
                        onSave: {
                            updatePassword()
                        }
                    )
                }
            }
        }
    }
    
    private func updatePassword() {
        AuthService.shared.updatePassword(currentPassword: currentPassword, newPassword: newPassword) { result in
            switch result {
            case .success(let message):
                alertTitle = "Success"
                errorMessage = message
                showAlert = true
                showModal = false
            case .failure(let error):
                alertTitle = "Error"
                errorMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
    
    private func logout() {
        AuthService.shared.logout { result in
            switch result {
            case .success:
                isLoggedIn = false
            case .failure(let error):
                errorMessage = error.localizedDescription
                showAlert = true
            }
        }
    }
}

#Preview {
    SettingsView()
}
