//
//  PoemCollectionViewModel.swift
//  Poemify
//
//  Created by Artem Doloban on 21.10.2024.
//

import SwiftUI

class PoemCollectionsViewModel: ObservableObject {
    @Published var collections: [PoemCollection] = [PoemCollection(name: "MyCollection")]

    func addPoem(_ poem: Poem, to collection: PoemCollection) {
        if let index = collections.firstIndex(where: { $0.id == collection.id }) {
            if !collections[index].poems.contains(poem) {
                collections[index].poems.append(poem)
                print("Added poem: \(poem.title) to collection \(collection.name)")
            }
        }
    }

    func removePoem(_ poem: Poem, from collection: PoemCollection) {
        if let index = collections.firstIndex(where: { $0.id == collection.id }) {
            collections[index].poems.removeAll { $0 == poem }
            print("Removed poem: \(poem.title) from collection \(collection.name)")
        }
    }

    func createCollection(name: String) {
        let newCollection = PoemCollection(name: name)
        collections.append(newCollection)
        print("Created new collection: \(name)")
    }
    
    func isPoemSavedInAnyCollection(_ poem: Poem) -> Bool {
        return collections.contains { $0.poems.contains(poem) }
    }
    
    func removeCollection(_ collection: PoemCollection) {
        collections.removeAll { $0.id == collection.id }
    }
}
