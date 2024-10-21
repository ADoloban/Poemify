//
//  SavedPoemsViewModel.swift
//  Poemify
//
//  Created by Artem Doloban on 17.10.2024.
//

import Foundation

import SwiftUI

class SavedPoemsViewModel: ObservableObject {
    @Published var savedPoems: [Poem] = []
    
    // Додавання вірша
    func addPoem(_ poem: Poem) {
        if !savedPoems.contains(where: { $0.title == poem.title && $0.author == poem.author }) {
            savedPoems.append(poem)
        }
    }
    
    // Видалення вірша
    func removePoem(_ poem: Poem) {
        savedPoems.removeAll { $0.title == poem.title && $0.author == poem.author }
    }
    
    // Перевірка, чи вірш збережений
    func isPoemSaved(_ poem: Poem) -> Bool {
        return savedPoems.contains(where: { $0.title == poem.title && $0.author == poem.author })
    }
}
