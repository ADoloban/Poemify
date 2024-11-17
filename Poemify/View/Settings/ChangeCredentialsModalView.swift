//
//  ChangePasswordModalView.swift
//  Poemify
//
//  Created by Artem Doloban on 14.11.2024.
//

import SwiftUI

struct ChangePasswordModalView: View {
    @Binding var isPresented: Bool
    @Binding var currentPassword: String
    @Binding var newPassword: String
    var onSave: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isPresented = false
                    clearFields()
                }
            
            VStack(spacing: 20) {
                Text("Update Password")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Color("FD8B51"))
                
                VStack(spacing: 20) {
                    StyledTextField(placeholder: "Current Password", text: $currentPassword, isSecure: true)
                        .foregroundColor(Color("EBE3D5"))
                    StyledTextField(placeholder: "New Password", text: $newPassword, isSecure: true)
                        .foregroundColor(Color("EBE3D5"))
                }
                .padding(.horizontal)
                
                Button(action: {
                    isPresented = false
                    onSave()
                    clearFields()
                }) {
                    Text("Save")
                }
                .padding(10)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .background(currentPassword.isEmpty || newPassword.isEmpty ? Color.gray : Color("FD8B51"))
                .foregroundColor(currentPassword.isEmpty || newPassword.isEmpty ? Color.white.opacity(0.7) : Color("C6EBC5"))
                .cornerRadius(20)
                .disabled(currentPassword.isEmpty || newPassword.isEmpty)
                .padding(.top, 20)
            }
            .frame(width: 300, height: 250)
            .background(Color(.white).opacity(0.4))
            .cornerRadius(20)
            .shadow(radius: 10)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }
    
    private func clearFields() {
        currentPassword = ""
        newPassword = ""
    }
}

struct StyledTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if isSecure {
                SecureField("", text: $text)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .foregroundStyle(Color("EBE3D5"))
                            .bold()
                    }
            } else {
                TextField("", text: $text)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
                    .foregroundStyle(Color("EBE3D5"))
                    .textFieldStyle(.plain)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .foregroundStyle(Color("EBE3D5"))
                            .bold()
                    }
            }
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(Color("EBE3D5"))
        }
        .padding(.horizontal, 16)
    }
}
