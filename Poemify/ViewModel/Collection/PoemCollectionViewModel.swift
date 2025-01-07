import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class PoemCollectionsViewModel: ObservableObject {
    @Published var collections: [PoemCollection] = []
    
    private let db = Firestore.firestore()
    
    func addPoem(_ poem: Poem, to collection: PoemCollection) {
        if let index = collections.firstIndex(where: { $0.id == collection.id }) {
            if !collections[index].poems.contains(poem) {
                collections[index].poems.append(poem)
                saveCollectionToFirestore(collections[index])
            }
        }
    }
    
    func removePoem(_ poem: Poem, from collection: PoemCollection) {
        if let index = collections.firstIndex(where: { $0.id == collection.id }) {
            collections[index].poems.removeAll { $0 == poem }
            saveCollectionToFirestore(collections[index])
        }
    }
    
    func createCollection(name: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let collectionRef = db.collection("users").document(userID).collection("collections").document()
        let firebaseID = collectionRef.documentID
        
        let newCollection = PoemCollection(id: firebaseID, name: name)
        
        collections.append(newCollection)
        collectionRef.setData([
            "name": name,
            "poems": []
        ]) { error in
            if let error = error {
                print("Error creating collection in Firestore: \(error.localizedDescription)")
            } else {
                print("Created new collection: \(name)")
            }
        }
    }
    
    func isPoemSavedInAnyCollection(_ poem: Poem) -> Bool {
        return collections.contains { $0.poems.contains(poem) }
    }
}

extension PoemCollectionsViewModel {
    
    func loadCollectionsFromFirestore() {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        DispatchQueue.main.async {
            self.collections.removeAll()
        }
        
        db.collection("users").document(userID).collection("collections").getDocuments { snapshot, error in
            if let _ = error {
                return
            }
            var loadedCollections: [PoemCollection] = []
            
            for document in snapshot?.documents ?? [] {
                let data = document.data()
                let id = document.documentID
                let name = data["name"] as? String ?? ""
                let poemsData = data["poems"] as? [[String: Any]] ?? []
                
                let poems = poemsData.compactMap { poemData -> Poem? in
                    guard
                        let title = poemData["title"] as? String,
                        let author = poemData["author"] as? String,
                        let lines = poemData["lines"] as? [String],
                        let linecount = poemData["linecount"] as? String
                    else {
                        return nil
                    }
                    
                    return Poem(title: title, author: author, lines: lines, linecount: linecount)
                }
                
                let collection = PoemCollection(id: id, name: name, poems: poems)
                if !self.collections.contains(where: { $0.name == collection.name }) {
                    loadedCollections.append(collection)
                }
            }
            
            DispatchQueue.main.async {
                self.collections.append(contentsOf: loadedCollections)
            }
        }
    }
    
    func saveCollectionToFirestore(_ collection: PoemCollection) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let collectionData: [String: Any] = [
            "name": collection.name,
            "poems": collection.poems.map { poem in
                [
                    "title": poem.title,
                    "author": poem.author,
                    "lines": poem.lines,
                    "linecount": poem.linecount
                ]
            }
        ]
        
        db.collection("users").document(userID).collection("collections").document(collection.id).setData(collectionData) { error in
            if let error = error {
                print("Error saving collection: \(error.localizedDescription)")
            } else {
                print("Collection saved successfully")
            }
        }
    }
    
    func saveAllCollectionsToFirestore() {
        for collection in collections {
            saveCollectionToFirestore(collection)
        }
    }
    
    func removeCollectionFromFirestore(_ collection: PoemCollection) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(userID).collection("collections").document(collection.id).delete { error in
            if let error = error {
                print("Error deleting collection: \(error.localizedDescription)")
            } else {
                print("Collection \(collection.name) deleted from Firestore.")
            }
        }
    }
    
    func removeCollection(_ collection: PoemCollection) {
        collections.removeAll { $0.id == collection.id }
        removeCollectionFromFirestore(collection)
    }
}
