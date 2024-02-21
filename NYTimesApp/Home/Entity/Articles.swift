//
//  HomeEntity.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 16/02/2024.
//

import Foundation

struct Article: Codable, Equatable {
    
    let id: Int
    let title: String?
    let abstract: String?
    let published_date: String?
    let byline: String?
    let media: [Media]
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
}

struct ArticleResponse: Codable  {
    let results: [Article]?
}

struct Media: Codable {
    let mediaMetadata: [Metadata]?
    let caption: String?
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
        case caption
    }
}
    
struct Metadata: Codable {
    let url: String?
}
