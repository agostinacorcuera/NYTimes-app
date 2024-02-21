//
//  DataManager.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 20/02/2024.
//

import Foundation
import Alamofire

class DataManager {
    
    static let shared = DataManager()
    
    static private let userDefaults = UserDefaults.standard
    static private let articlesKey = "SavedArticles"
    
    static func saveArticles(_ articles: [Article]) {
        let encodedData = try? JSONEncoder().encode(articles)
        userDefaults.set(encodedData, forKey: articlesKey)
    }
    
    static func loadSavedArticles() -> [Article] {
        if let encodedData = userDefaults.data(forKey: articlesKey),
           let articles = try? JSONDecoder().decode([Article].self, from: encodedData) {
            return articles
        }
        return []
    }
}
