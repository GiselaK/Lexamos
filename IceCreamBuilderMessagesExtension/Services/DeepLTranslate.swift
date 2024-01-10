//
//  DeepLTranslate.swift
//  IceCreamBuilder
//
//  Created by Gisela K on 11/20/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

func translateTextWithDeepL(text: String, targetLanguage: String, completion: @escaping (String?) -> Void) {
    let apiKey = "YOUR_DEEPL_API_KEY"
    let urlString = "https://api-free.deepl.com/v2/translate"
    guard let url = URL(string: urlString) else {
        completion(nil)
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let parameters: [String: String] = [
        "auth_key": apiKey,
        "text": text,
        "target_lang": targetLanguage
    ]
    
    // Convert parameters to URL-encoded query
    let bodyString = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    request.httpBody = bodyString.data(using: .utf8)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            completion(nil)
            return
        }
        
        guard let data = data else {
            completion(nil)
            return
        }
        
        // Parse the JSON response
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let translations = json["translations"] as? [[String: Any]],
               let translatedText = translations.first?["text"] as? String {
                completion(translatedText)
            } else {
                completion(nil)
            }
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
            completion(nil)
        }
    }
    
    task.resume()
}
