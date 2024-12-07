import Foundation

enum PoemRequestType {
    case allPoems
    case search(author: String?, title: String?, numberOfLines: Int?, poemCount: Int?)
}
