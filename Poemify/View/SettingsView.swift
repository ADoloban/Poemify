//
//  SettingsView.swift
//  Poemify
//
//  Created by Artem Doloban on 11.10.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General Settings")) {
                    Toggle("Enable Notifications", isOn: .constant(true))
                    Toggle("Dark Mode", isOn: .constant(false))
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    SettingsView()
}
