//
//  CreatePoemView.swift
//  Poemify
//
//  Created by Artem Doloban on 25.10.2024.
//

import SwiftUI

struct CreatePoemView: View {
    var collection: PoemCollection
    @EnvironmentObject var collectionsViewModel: PoemCollectionsViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var poemText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Author", text: $author)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextEditor(text: $poemText)
                    .frame(height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding()
                
                Spacer()
                
                Button(action: savePoem) {
                    Text("Save Poem")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(title.isEmpty || poemText.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(title.isEmpty || poemText.isEmpty)
                .padding(.bottom)
            }
            .navigationTitle("Create Poem")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func savePoem() {
        let lines = poemText.split(separator: "\n").map(String.init)
        let poemAuthor = author.isEmpty ? "Your own poem" : author
        let newPoem = Poem(title: title, author: poemAuthor, lines: lines, linecount: "\(lines.count)")
        
        // Додаємо новий вірш до колекції
        collectionsViewModel.addPoem(newPoem, to: collection)
        
        dismiss()
    }
}

#Preview {
    CreatePoemView(collection: PoemCollection(name: "Example"))
        .environmentObject(PoemCollectionsViewModel())
}
