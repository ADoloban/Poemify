//
//  CreateCollectionModalView.swift
//  Poemify
//
//  Created by Artem Doloban on 17.11.2024.
//

import SwiftUI

struct CreateCollectionModalView: View {
    @Binding var isPresented: Bool
    @Binding var collectionName: String
    var onSave: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isPresented = false
                    clearFields()
                }

            VStack(spacing: 20) {
                Text("Create New Collection")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Color("FD8B51"))

                VStack(spacing: 20) {
                    StyledTextField(
                        placeholder: "Collection Name",
                        text: $collectionName,
                        isSecure: false
                    )
                    .foregroundColor(Color("EBE3D5"))
                }
                .padding(.horizontal)

                Button(action: {
                    isPresented = false
                    onSave()
                    clearFields()
                }) {
                    Text("Create")
                }
                .padding(10)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .background(collectionName.isEmpty ? Color.gray : Color("FD8B51"))
                .foregroundColor(collectionName.isEmpty ? Color.white.opacity(0.7) : Color("C6EBC5"))
                .cornerRadius(20)
                .disabled(collectionName.isEmpty)
                .padding(.top)
            }
            .frame(width: 300, height: 200)
            .background(Color(.gray).opacity(0.8))
            .cornerRadius(20)
            .shadow(radius: 10)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }

    private func clearFields() {
        collectionName = ""
    }
}
