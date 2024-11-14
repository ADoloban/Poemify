//
//  PoemifyApp.swift
//  Poemify
//
//  Created by Artem Doloban on 08.10.2024.
//

import SwiftUI
import Firebase

@main
struct PoemifyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var collectionsViewModel = PoemCollectionsViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn = false 
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView()
                    .environmentObject(collectionsViewModel)
            } else {
                RegistrationView()
                    .environmentObject(collectionsViewModel)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
