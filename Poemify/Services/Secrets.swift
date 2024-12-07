//
//  Secrets.swift
//  Poemify
//
//  Created by Artem Doloban on 07.12.2024.
//

import Foundation

class Secrets {
    static var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: path),
              let apiKey = dictionary["API_KEY"] as? String else {
            fatalError("API don't found in Secrets.plist")
        }
        return apiKey
    }
}
