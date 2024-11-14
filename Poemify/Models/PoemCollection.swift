//
//  PoemCollection.swift
//  Poemify
//
//  Created by Artem Doloban on 21.10.2024.
//

import SwiftUI

struct PoemCollection: Identifiable, Hashable {
    let id: String
    var name: String
    var poems: [Poem] = []
    
    init(id: String, name: String, poems: [Poem] = []) {
        self.id = id
        self.name = name
        self.poems = poems
    }
}
