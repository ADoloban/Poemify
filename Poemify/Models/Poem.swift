//
//  Poem.swift
//  Poemify
//
//  Created by Artem Doloban on 09.10.2024.
//

import Foundation

struct Poem: Codable, Hashable {
    let title: String
    let author: String
    let lines: [String]
    let linecount: String
}
