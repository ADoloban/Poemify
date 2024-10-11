//
//  ContentView.swift
//  Poemify
//
//  Created by Artem Doloban on 08.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PoemViewModel()
    @State private var isSearchActive = false
    
    var body: some View {
        NavigationView {
            List(viewModel.poems, id:\.self) { poem in
                PoemCell(poem: poem)
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(NavigationLink("", destination: PoemDetailView(poem: poem)))
            }
            .onAppear {
                viewModel.fetchAllPoems()
            }
            .toolbar {
                // Кнопка лупи у верхньому правому куті
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isSearchActive = true  // Відкриваємо екран пошуку
                    }) {
                        Image(systemName: "magnifyingglass")  // Іконка лупи
                    }
                }
            }
            .sheet(isPresented: $isSearchActive) {
                SearchView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
