//
//  ArticleModule.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 19/02/2024.
//

import Foundation
import UIKit

class ArticleModule {
    static func build(with article: Article) -> UIViewController {
        let view = ArticleViewController(article: article)
        
        return view
    }
}
