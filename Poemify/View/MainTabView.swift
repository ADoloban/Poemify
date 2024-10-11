//
//  MainTabView.swift
//  Poemify
//
//  Created by Artem Doloban on 10.10.2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                ContentView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Poems")
            }
            
            NavigationView {
                SavedPoemsView()
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Saved")
            }
        }
    }
}

#Preview {
    MainTabView()
}
