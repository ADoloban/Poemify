import Foundation

class PoemAPIService {
    private let baseURL = "https://poetrydb.org"
    
    func fetchPoems(requestType: PoemRequestType, completion: @escaping ([Poem]) -> Void) {
        var urlString = [String]()
        var tempUrl = [String]()
        var resultUrl: String
        
        switch requestType {
        case .allPoems:
            resultUrl = "\(baseURL)/author/ "  
        case .search(let author, let title, let linecount, let poemcount):
            
            if let title, !title.isEmpty {
                urlString.append("title")
                tempUrl.append("\(title)")
            }
            if let author, !author.isEmpty {
                urlString.append("author")
                tempUrl.append("\(author)")
            }
            if let linecount, linecount > 0 {
                urlString.append("linecount")
                tempUrl.append("\(linecount)")
            }
            if let poemcount, poemcount > 0 {
                urlString.append("poemcount")
                tempUrl.append("\(poemcount)")
            }
            
            resultUrl = baseURL + "/" + urlString.joined(separator: ",") + "/" + tempUrl.joined(separator: ";")
            print(resultUrl)
        }
        
        guard let url = URL(string: resultUrl) else {
            print("Invalid URL")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedPoems = try JSONDecoder().decode([Poem].self, from: data)
                    completion(decodedPoems)
                } catch {
                    completion([])
                }
            } else {
                completion([])
            }
        }.resume()
    }
}


