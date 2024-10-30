//
//  PoemifyApp.swift
//  Poemify
//
//  Created by Artem Doloban on 08.10.2024.
//

import SwiftUI

@main
struct PoemifyApp: App {
    @StateObject private var collectionsViewModel = PoemCollectionsViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn = false 
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView()
                    .environmentObject(collectionsViewModel)
            } else {
                LoginView()
                    .environmentObject(collectionsViewModel)
            }
        }
    }
}
