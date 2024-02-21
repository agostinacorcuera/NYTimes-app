//
//  HomeInteractor.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 15/02/2024.
//

import Foundation
import PromiseKit
import Alamofire

protocol HomeInteractorProtocol: AnyObject {
    func getArticles(completion: @escaping ([Article]?, Error?) -> Void)
}

class HomeInteractor: HomeInteractorProtocol {
    
    func getArticles(completion: @escaping ([Article]?, Error?) -> Void) {
        let apiKey = "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ"
        let urlString = "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "ArticleInteractor", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "ArticleInteractor", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ArticleResponse.self, from: data)
                completion(result.results, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
