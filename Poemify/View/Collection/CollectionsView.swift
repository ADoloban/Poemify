//
//  CollectionsView.swift
//  Poemify
//
//  Created by Artem Doloban on 21.10.2024.
//

import SwiftUI

struct CollectionsView: View {
    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
    @State private var newCollectionName = ""
    @State private var isAddingNewCollection = false
    
    var body: some View {
        List {
            ForEach(collectionsViewModel.collections) { collection in
                NavigationLink(destination: CollectionView(collection: collection)
                    .environmentObject(collectionsViewModel)) {
                        Text(collection.name)
                            .font(.headline)
                    }
            }
            .onDelete(perform: deleteCollection)
        }
        .navigationTitle("Collections")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isAddingNewCollection = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .overlay {
            ZStack {
                if isAddingNewCollection {
                    // Фон із затемненням позаду модального вікна
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            isAddingNewCollection = false
                        }
                    
                    // Вікно посередині
                    VStack {
                        Text("Create New Collection")
                            .font(.headline)
                            .padding(.top)
                        
                        TextField("Collection Name", text: $newCollectionName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        Button("Create") {
                            collectionsViewModel.createCollection(name: newCollectionName)
                            newCollectionName = ""
                            isAddingNewCollection = false
                        }
                        .padding()
                        .disabled(newCollectionName.isEmpty)
                    }
                    .frame(width: 300, height: 200)
                    .background(Color(.systemBackground))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
            }
        }
    }
    
    private func deleteCollection(at offsets: IndexSet) {
        offsets.forEach { index in
            let collection = collectionsViewModel.collections[index]
            collectionsViewModel.removeCollection(collection)
        }
    }
}

#Preview {
    CollectionsView()
}
