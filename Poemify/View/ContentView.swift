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
    @State private var isSettingsActive = false
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            if isLoading {
                // Показуємо індикатор завантаження, якщо дані ще не завантажені
                ProgressView("Loading Poems...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)  // Збільшуємо розмір індикатора
            } else {
                // Відображаємо список віршів після завантаження даних
                List(viewModel.poems, id: \.self) { poem in
                    PoemCell(poem: poem)
                        .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .background(NavigationLink("", destination: PoemDetailView(poem: poem)))
                }
            }
        }
        .onAppear {
            viewModel.fetchAllPoems {
                isLoading = false
            }
        }
        .navigationTitle("Poems")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isSearchActive = true
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18))
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isSettingsActive = true
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 18))
                }
            }
        }
        .sheet(isPresented: $isSearchActive) {
            SearchView(viewModel: viewModel)
        }
        .sheet(isPresented: $isSettingsActive) {
            SettingsView()  
        }
    }
    
}

#Preview {
    ContentView()
}
