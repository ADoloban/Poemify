//
//  CollectionView.swift
//  Poemify
//
//  Created by Artem Doloban on 21.10.2024.
//

import SwiftUI

struct CollectionView: View {
    var collection: PoemCollection
    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
    @State private var isCreatingPoem = false
    
    var body: some View {
        ZStack {
            VStack {
                Text(collection.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if collection.poems.isEmpty {
                    Spacer()
                    Text("No saved poems in this collection.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    Spacer()
                } else {
                    List {
                        ForEach(collection.poems, id: \.self) { poem in
                            PoemCell(poem: poem)
                                .padding(.vertical, 10)
                                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .background(
                                    NavigationLink(
                                        destination: PoemDetailView(poem: poem)
                                            .environmentObject(collectionsViewModel)
                                    ) {
                                        EmptyView()
                                    }
                                        .opacity(0))
                        }
                        .onDelete(perform: deletePoem)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isCreatingPoem = true
                    }) {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50) // Зменшений розмір значка
                            .foregroundColor(.blue) // Колір іконки
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isCreatingPoem) {
            CreatePoemView(collection: collection)
                .environmentObject(collectionsViewModel)
        }
    }

    private func deletePoem(at offsets: IndexSet) {
        for index in offsets {
            let poemToDelete = collection.poems[index]
            collectionsViewModel.removePoem(poemToDelete, from: collection)
        }
    }
}
