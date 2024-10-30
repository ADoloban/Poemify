//
//  ContentView.swift
//  Poemify
//
//  Created by Artem Doloban on 08.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PoemViewModel()
    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
    
    @State private var isSearchActive = false
    @State private var isSettingsActive = false
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView("Loading Poems...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            } else {
                if let errorMessage = viewModel.errorMessage {
                    ContentUnavailableView {
                        Label("No Results", systemImage: "magnifyingglass")
                    } description: {
                        Text(errorMessage)
                    }
                } else if viewModel.poems.isEmpty {
                    ContentUnavailableView.search
                } else {
                    List(viewModel.poems, id: \.self) { poem in
                        PoemCell(poem: poem)
                            .padding(.vertical, 10)
                            .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .background(
                                NavigationLink("", destination: PoemDetailView(poem: poem)
                                    .environmentObject(viewModel)
                                    .environmentObject(collectionsViewModel)
                                )
                            )
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .onAppear {
            viewModel.fetchAllPoems {
                withAnimation {
                    isLoading = false
                }
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
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    isSettingsActive = true
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 18))
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    reloadPoems()
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 18))
                }
            }
        }
        .sheet(isPresented: $isSearchActive) {
            SearchView(isSearchActive: $isSearchActive, viewModel: viewModel)
        }
        .fullScreenCover(isPresented: $isSettingsActive) {
            SettingsView()
        }
    }
    
    private func reloadPoems() {
            isLoading = true
            viewModel.fetchAllPoems {
                withAnimation {
                    isLoading = false
                }
            }
    }
}

#Preview {
    ContentView()
}
