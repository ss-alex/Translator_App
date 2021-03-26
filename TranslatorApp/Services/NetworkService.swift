//
//  NetworkService.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit

protocol NetworkServiceProtocol {
    func translate(text: String, fromLang: String, toLang: String, completion: @escaping (TranslationResult?, Error?) -> ())
    
    var supportedLanguages: [Language] { get }
}

class NetworkService: NetworkServiceProtocol {
    let baseUrl = Network.baseUrl
    let apiKey = Network.apiKey
    let version = Network.version
    
    var supportedLanguages: [Language] {
        var languages: [Language] = []
        languages.append(Language(name: "Russian", code: "ru"))
        languages.append(Language(name: "English", code: "en"))
        languages.append(Language(name: "Spanish", code: "es"))
        return languages
    }
    
    func translate(text: String,
                  fromLang: String,
                  toLang: String,
                  completion: @escaping (TranslationResult?, Error?) -> ()) {
        request(text: text, fromLang: fromLang, toLang: toLang, completion: completion)
    }
    
    private func request(text: String,
                         fromLang: String,
                         toLang: String,
                         completion: @escaping (TranslationResult?, Error?) -> ()) {
        
        let parameters: [String : Any] = [
            "text": [text], "model_id": "\(fromLang)-\(toLang)"
        ]

        let url = URL(string: baseUrl + "/v3/translate?version=\(version)")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Basic \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(TranslationResult.self, from: data)
                completion(response, nil)
            } catch let error {
                completion(nil, error)
            }
        })
        task.resume()
    }
}


