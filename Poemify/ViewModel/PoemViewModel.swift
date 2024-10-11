//
//  PoetryViewModel.swift
//  Poemify
//
//  Created by Artem Doloban on 09.10.2024.
//
import Foundation

class PoemViewModel: ObservableObject {
    @Published var poems: [Poem] = []
    private var poetryService = PoemAPIService()

    func fetchAllPoems() {
        poetryService.fetchPoems(requestType: .allPoems) { [weak self] poems in
            DispatchQueue.main.async {
                self?.poems = poems
            }
        }
    }

    func searchPoems(author: String? = nil, title: String? = nil, numberOfLines: Int? = nil, resultCount: Int? = nil, random: Bool = false) {
        poetryService.fetchPoems(requestType: .search(author: author, title: title, numberOfLines: numberOfLines, resultCount: resultCount, random: random)) { [weak self] poems in
            DispatchQueue.main.async {
                self?.poems = poems
            }
        }
    }
}
