//
//  PoemAPIService.swift
//  Poemify
//
//  Created by Artem Doloban on 09.10.2024.
//

import Foundation

class PoemAPIService {
    private let baseURL = "https://poetrydb.org"
    
    func fetchAllPoems(completion: @escaping ([Poem]) -> Void) {
        guard let url = URL(string: "\(baseURL)/author/Robert Burns") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedPoems = try JSONDecoder().decode([Poem].self, from: data)
                    completion(decodedPoems)  // Передаємо результат через замикання
                } catch {
                    print("Error decoding data: \(error)")
                    completion([])  // У випадку помилки передаємо порожній масив
                }
            } else {
                completion([])  // У випадку помилки передаємо порожній масив
            }
        }.resume()
    }
}
