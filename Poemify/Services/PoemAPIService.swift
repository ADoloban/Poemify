//
//  PoemAPIService.swift
//  Poemify
//
//  Created by Artem Doloban on 09.10.2024.
//

import Foundation

class PoemAPIService {
    private let baseURL = "https://poetrydb.org"

    func fetchPoems(requestType: PoemRequestType, completion: @escaping ([Poem]) -> Void) {
        var urlString: String
        
        // Визначаємо URL на основі типу запиту
        switch requestType {
        case .allPoems:
            urlString = "\(baseURL)/author/ "  // Викликаємо API для отримання всіх віршів
        case .search(let author, let title, let numberOfLines, let resultCount, let random):
            var queryItems = [URLQueryItem]()
            
            // Додаємо параметри до запиту, якщо вони задані
            if let author = author, !author.isEmpty {
                queryItems.append(URLQueryItem(name: "author", value: author))
            }
            if let title = title, !title.isEmpty {
                queryItems.append(URLQueryItem(name: "title", value: title))
            }
            if let numberOfLines = numberOfLines {
                queryItems.append(URLQueryItem(name: "lines", value: "\(numberOfLines)"))
            }
            if let resultCount = resultCount {
                queryItems.append(URLQueryItem(name: "count", value: "\(resultCount)"))
            }
            if random {
                queryItems.append(URLQueryItem(name: "random", value: "true"))
            }
            
            // Формуємо URL для пошуку
            var urlComponents = URLComponents(string: "\(baseURL)/author,title,lines,count/random")!
            urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
            urlString = urlComponents.string ?? ""
        }
        
        // Перевіряємо, чи вдалось створити URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion([])
            return
        }
        
        // Виконуємо запит
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedPoems = try JSONDecoder().decode([Poem].self, from: data)
                    completion(decodedPoems)
                } catch {
                    print("Error decoding data: \(error)")
                    completion([])
                }
            } else {
                completion([])
            }
        }.resume()
    }
}

//class PoemAPIService {
//    private let baseURL = "https://poetrydb.org"
//    
//    func fetchAllPoems(completion: @escaping ([Poem]) -> Void) {
//        guard let url = URL(string: "\(baseURL)/author/ ") else { return }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                do {
//                    let decodedPoems = try JSONDecoder().decode([Poem].self, from: data)
//                    completion(decodedPoems)
//                } catch {
//                    print("Error decoding data: \(error)")
//                    completion([])
//                }
//            } else {
//                completion([])
//            }
//        }.resume()
//    }
//}
