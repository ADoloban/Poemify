//
//  PoemCollection.swift
//  Poemify
//
//  Created by Artem Doloban on 21.10.2024.
//

import SwiftUI

struct PoemCollection: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var poems: [Poem] = []
}
