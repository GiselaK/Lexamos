//
//  Klipy.swift
//  IceCreamBuilderMessagesExtension
//
//  Created by Gisela K on 11/19/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import Alamofire

class KlipyService {
    private let apiKey = "sandbox-mJokm7E2jH"

    
    func fetchGIFs(query: String, completion: @escaping (Result<[String], Error>) -> Void) {
        let baseURL = "https://api.klipy.co/api/v1/\(apiKey)" // Hypothetical URL
        let url = "\(baseURL)/stickers/search"
        let parameters: [String: Any] = [
            "customer_id": "lex", //Update to user id?
            "q": query
        ]

        AF.request(url, parameters: parameters, encoding: URLEncoding.queryString).responseJSON { response in
            switch response.result {
            case .success(let data):
                print("Data: \(data)")
                
                guard let json = data as? [String: Any],
                      let result = json["result"] as? Bool, result, // Validate the "result" flag
                      let dataContainer = json["data"] as? [String: Any],
                      let gifs = dataContainer["data"] as? [[String: Any]] else {
                    completion(.failure(NSError(domain: "Parsing Error", code: -1, userInfo: nil)))
                    return
                }
                
                // Extract the "url" values from each GIF object
                let gifURLs: [String] = gifs.compactMap { gif in
                    // Attempt to extract the "file" dictionary
                    guard let file = gif["file"] as? [String: Any],
                          let sm = file["sm"] as? [String: Any],
                          let gifData = sm["gif"] as? [String: Any],
                          let url = gifData["url"] as? String else {
                        return nil
                    }
                    return url
                }

                
                if gifURLs.isEmpty {
                    completion(.failure(NSError(domain: "No GIF URLs Found", code: -2, userInfo: nil)))
                } else {
                    completion(.success(gifURLs))
                }

            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
            
        
            
        
        }
    }
}
