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
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Poems")
                }
            
            SavedPoemsView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Saved")
                }
        }
    }
}

#Preview {
    MainTabView()
}
