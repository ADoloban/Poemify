//
//  SearchView.swift
//  Poemify
//
//  Created by Artem Doloban on 11.10.2024.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: PoemViewModel  // Доступ до ViewModel
    @State private var author = ""
    @State private var title = ""
    @State private var numberOfLines: String = ""
    @State private var resultCount: String = ""
    @State private var random = false

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Search settings")) {
                    TextField("Author", text: $author)
                    TextField("Title", text: $title)
                    TextField("Number of lines", text: $numberOfLines)
                        .keyboardType(.numberPad)
                    TextField("Result count", text: $resultCount)
                        .keyboardType(.numberPad)
                    Toggle("Return random poems?", isOn: $random)
                }
                
                Button(action: {
                    let lines = Int(numberOfLines)
                    let count = Int(resultCount)
                    
                    viewModel.searchPoems(author: author.isEmpty ? nil : author,
                                          title: title.isEmpty ? nil : title,
                                          numberOfLines: lines,
                                          resultCount: count,
                                          random: random)
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Search")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Search Poems")
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
