//
//  SavedPoemsView.swift
//  Poemify
//
//  Created by Artem Doloban on 10.10.2024.
//

import SwiftUI

struct SavedPoemsView: View {
    @EnvironmentObject var savedPoemsViewModel: SavedPoemsViewModel // Підключаємо ViewModel
    
    var body: some View {
        if savedPoemsViewModel.savedPoems.isEmpty {
            Text("No saved poems yet.")
                .foregroundColor(.gray)
        } else {
            List(savedPoemsViewModel.savedPoems, id: \.self) { poem in
                PoemCell(poem: poem) // Використовуємо PoemCell як у ContentView
                    .padding(.vertical, 10)
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .background(
                        NavigationLink("",
                                       destination: PoemDetailView(poem: poem)
                            .environmentObject(savedPoemsViewModel)
                                      ))
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Saved Poems")// Використовуємо PlainListStyle як у ContentView
        }
    }
}
