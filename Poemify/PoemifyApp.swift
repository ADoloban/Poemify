//
//  PoemifyApp.swift
//  Poemify
//
//  Created by Artem Doloban on 08.10.2024.
//

import SwiftUI

@main
struct PoemifyApp: App {
    @StateObject private var viewModel = SavedPoemsViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(viewModel) 
        }
    }
}
