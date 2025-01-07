import Foundation

class PoemGeneratorAPIClient {
    private let apiKey = Secrets.apiKey
    private let baseURL = "https://api.openai.com/v1/chat/completions"

    func generatePoem(theme: String, keywords: [String], language: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let prompt = """
        Напиши вірш на тему "\(theme)" мовою \(language).
        Можеш використати ключові слова: \(keywords.joined(separator: ", ")).
        Якщо написано незрозумілі слова, то просто напиши повідомлення: "Generating error".
        Форматуй текст по рядках.
        """

        let requestBody: [String: Any] = [
            "model": "gpt-4",
            "messages": [
                ["role": "system", "content": "Ти — поет. Твоя задача — створювати гарні вірші."],
                ["role": "user", "content": prompt]
            ]
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completion(content)
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }

        task.resume()
    }
}
