//
//  SettingsView.swift
//  Poemify
//
//  Created by Artem Doloban on 11.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isLoggedIn") private var isLoggedIn = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General Settings")) {
                    Toggle("Enable Notifications", isOn: .constant(true))
                    Toggle("Dark Mode", isOn: .constant(false))
                }

                // Додаємо кнопку виходу
                Section {
                    Button(action: logout) {
                        Text("Logout")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func logout() {
        isLoggedIn = false
        presentationMode.wrappedValue.dismiss() // Закриваємо SettingsView
    }
}

#Preview {
    SettingsView()
}
