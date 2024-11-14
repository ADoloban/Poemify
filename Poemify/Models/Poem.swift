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
    
    func createShareableText() -> String {
        return """
        Title: \(self.title)
        
        by \(self.author)
        
        \(self.lines.joined(separator: "\n"))
        """
    }
    
    var cleanedLines: [String] {
        lines
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
    
}

