//
//  MainTabView.swift
//  Poemify
//
//  Created by Artem Doloban on 10.10.2024.
//

import SwiftUI

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var viewModel: PoemCollectionsViewModel
    
    var body: some View {
        TabView {
            NavigationView {
                ContentView()
                    .environmentObject(viewModel)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Poems")
            }
            
            NavigationView {
                CollectionsView()
                    .environmentObject(viewModel)
            }
            .tabItem {
                Image(systemName: "bookmark.fill")
                Text("Collections")
            }
        }
    }
}

#Preview {
    MainTabView()
}
