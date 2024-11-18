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
    @Environment(\.dismiss) var dismiss

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
                    Text("Add to Collections")
                        .font(.title2.bold())
                        .foregroundStyle(Color("C6EBC5"))

                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Cancel")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("C6EBC5"))
                        }
                        .padding(.leading, 16)

                        Spacer()

                        Button(action: {
                            saveSelections()
                            dismiss()
                        }) {
                            Text("Save")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("C6EBC5"))
                        }
                        .padding(.trailing, 16)
                    }
                }
                .padding(.vertical, 8)

                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(collectionsViewModel.collections, id: \.self) { collection in
                            HStack {
                                Text(collection.name)
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color("C6EBC5"))
                                
                                Spacer()
                                
                                Image(systemName: selectedCollections.contains(collection) ? "checkmark.circle.fill" : "circle")
                                    .font(.system(size: 8))
                                    .foregroundColor(selectedCollections.contains(collection) ? Color("C6EBC5") : Color("C6EBC5"))
                                    .scaleEffect(3)
                                    .contentTransition(.symbolEffect(.replace))
                                    .onTapGesture {
                                        toggleSelection(for: collection)
                                    }
                            }
                            .padding()
                            .background(Color("C6EBC5").opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .onAppear {
                    preselectCollections()
                }
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

//struct AddToCollectionsView: View {
//    var poem: Poem
//    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
//    @State private var selectedCollections: Set<PoemCollection> = []
//    @State private var initialSelectedCollections: Set<PoemCollection> = []
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(collectionsViewModel.collections, id: \.self) { collection in
//                    HStack {
//                        Text(collection.name)
//                        Spacer()
//                        Image(systemName: selectedCollections.contains(collection) ? "checkmark.circle.fill" : "circle")
//                            .foregroundColor(.blue)
//                            .font(.system(size: 20))
//                            .onTapGesture {
//                                toggleSelection(for: collection)
//                            }
//                    }
//                }
//            }
//            .navigationTitle("Add to Collections")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
//                        dismiss()
//                    }
//                }
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Save") {
//                        saveSelections()
//                        dismiss()
//                    }
//                }
//            }
//            .onAppear {
//                preselectCollections()
//            }
//        }
//    }
//    
//    private func toggleSelection(for collection: PoemCollection) {
//        withAnimation {
//            if selectedCollections.contains(collection) {
//                selectedCollections.remove(collection)
//            } else {
//                selectedCollections.insert(collection)
//            }
//        }
//    }
//    
//    private func preselectCollections() {
//        for collection in collectionsViewModel.collections {
//            if collection.poems.contains(poem) {
//                selectedCollections.insert(collection)
//            }
//        }
//        initialSelectedCollections = selectedCollections
//    }
//    
//    private func saveSelections() {
//        for collection in collectionsViewModel.collections {
//            if selectedCollections.contains(collection) {
//                collectionsViewModel.addPoem(poem, to: collection)
//            } else {
//                collectionsViewModel.removePoem(poem, from: collection)
//            }
//        }
//    }
//}
