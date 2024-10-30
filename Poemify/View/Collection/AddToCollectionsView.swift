//
//  SelectCollectionsView.swift
//  Poemify
//
//  Created by Artem Doloban on 22.10.2024.
//

import SwiftUI

struct AddToCollectionsView: View {
    var poem: Poem
    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
    @State private var selectedCollections: Set<PoemCollection> = []
    @State private var initialSelectedCollections: Set<PoemCollection> = []
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                ForEach(collectionsViewModel.collections, id: \.self) { collection in
                    HStack {
                        Text(collection.name)
                        Spacer()
                        Image(systemName: selectedCollections.contains(collection) ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                            .onTapGesture {
                                toggleSelection(for: collection)
                            }
                    }
                }
            }
            .navigationTitle("Add to Collections")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveSelections()
                        dismiss()
                    }
                }
            }
            .onAppear {
                preselectCollections()
            }
        }
    }
    
    private func toggleSelection(for collection: PoemCollection) {
        withAnimation {
            if selectedCollections.contains(collection) {
                selectedCollections.remove(collection)
            } else {
                selectedCollections.insert(collection)
            }
        }
    }
    
    private func preselectCollections() {
        for collection in collectionsViewModel.collections {
            if collection.poems.contains(poem) {
                selectedCollections.insert(collection)
            }
        }
        initialSelectedCollections = selectedCollections
    }
    
    private func saveSelections() {
        for collection in collectionsViewModel.collections {
            if selectedCollections.contains(collection) {
                collectionsViewModel.addPoem(poem, to: collection)
            } else {
                collectionsViewModel.removePoem(poem, from: collection)
            }
        }
    }
}
