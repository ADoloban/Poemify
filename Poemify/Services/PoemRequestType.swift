//
//  PoemRequestType.swift
//  Poemify
//
//  Created by Artem Doloban on 11.10.2024.
//

import Foundation

enum PoemRequestType {
    case allPoems
    case search(author: String?, title: String?, numberOfLines: Int?, poemCount: Int?)
}
