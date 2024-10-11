//
//  SavedPoemsView.swift
//  Poemify
//
//  Created by Artem Doloban on 10.10.2024.
//

import SwiftUI

struct SavedPoemsView: View {
    @State private var savedPoems: [Poem] = []  
    
    var body: some View {
        NavigationView {
            VStack {
                if savedPoems.isEmpty {
                    Text("You haven't saved any poems yet!")
                        .font(.title3)
                        .foregroundColor(.gray)
                } else {
                    List(savedPoems, id: \.self) { poem in
                        Text(poem.title)
                    }
                }
            }
            .navigationTitle("Saved Poems")
        }
    }
}
