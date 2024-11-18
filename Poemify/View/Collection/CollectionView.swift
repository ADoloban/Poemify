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
    @Environment(\.presentationMode) var presentationMode
    @State private var isCreatingPoem = false
    @State private var selectedPoem: Poem?
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("01204E"), Color("257180")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    Text(collection.name)
                        .font(.title)
                        .foregroundStyle(Color("C6EBC5"))
                        .bold()
                    
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("C6EBC5"))
                                .padding(.leading, 16)
                        }
                        
                        Spacer()
                    }
                }
                .padding(.vertical, 8)
                
                ZStack {
                    if collection.poems.isEmpty {
                        Spacer()
                        Text("No saved poems in this collection.")
                            .foregroundStyle(Color("C6EBC5"))
                            .font(.headline)
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(collection.poems, id: \.self) { poem in
                                    NavigationLink(destination: PoemDetailView(poem: poem)
                                        .environmentObject(collectionsViewModel)) {
                                            PoemCell(poem: poem)
                                        }
                                        .buttonStyle(PlainButtonStyle()) // Щоб зберегти стиль клітинки
                                        .contextMenu {
                                            Button(role: .destructive) {
                                                deletePoem(poem)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                }
                            }
                            .padding(.horizontal, 16)
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
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color("257180"))
                                    .background(Color("C6EBC5"))
                                    .clipShape(Circle())
                                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                            }
                            .padding(.trailing, 20)
                            .padding(.bottom, 20)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $isCreatingPoem) {
                CreatePoemView(collection: collection)
                    .environmentObject(collectionsViewModel)
            }
        }
    }
    
    private func deletePoem(_ poem: Poem) {
        collectionsViewModel.removePoem(poem, from: collection)
    }
}

