//
//  PoetryViewModel.swift
//  Poemify
//
//  Created by Artem Doloban on 09.10.2024.
//
import Foundation

class PoemViewModel: ObservableObject {
    @Published var poems: [Poem] = []
    @Published var errorMessage: String? = nil
    
    private var poetryService = PoemAPIService()
    
    func fetchAllPoems(completion: @escaping () -> Void) {
        poetryService.fetchPoems(requestType: .allPoems) { [weak self] poems in
            DispatchQueue.main.async {
                if poems.isEmpty {
                    self?.errorMessage = "No poems available at the moment."
                } else {
                    self?.poems = poems
                }
                completion()
            }
        }
    }

    func searchPoems(author: String? = nil, title: String? = nil, numberOfLines: Int? = nil, resultCount: Int? = nil, random: Bool = false) {
        poetryService.fetchPoems(requestType: .search(author: author, title: title, numberOfLines: numberOfLines, poemCount: resultCount)) { [weak self] poems in
            DispatchQueue.main.async {
                if poems.isEmpty {
                    self?.errorMessage = "No poems found for the given criteria."
                } else {
                    self?.poems = poems
                }
            }
        }
    }
}
