import SwiftUI

struct CollectionsView: View {
    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
    @State private var newCollectionName = ""
    @State private var isAddingNewCollection = false
    
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
                    Text("Collections")
                        .font(.title)
                        .foregroundStyle(Color("C6EBC5"))
                        .bold()
                        
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isAddingNewCollection = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 22))
                                .foregroundColor(Color("C6EBC5"))
                                .padding(.trailing, 16)
                        }
                    }
                }
                .padding(.vertical, 10)
                
                if collectionsViewModel.collections.isEmpty {
                    Spacer()
                    Text("No collections available")
                        .font(.headline)
                        .foregroundColor(Color("C6EBC5"))
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(collectionsViewModel.collections) { collection in
                                NavigationLink(destination: CollectionView(collection: collection)
                                    .environmentObject(collectionsViewModel)) {
                                        CollectionCell(collection: collection)
                                            .contextMenu {
                                                Button(role: .destructive) {
                                                    collectionsViewModel.removeCollection(collection)
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                            }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .overlay {
                if isAddingNewCollection {
                    CreateCollectionModalView(
                        isPresented: $isAddingNewCollection,
                        collectionName: $newCollectionName
                    ) {
                        collectionsViewModel.createCollection(name: newCollectionName)
                    }
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
