//
//  HomeRouter.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 15/02/2024.
//

import Foundation
import UIKit

protocol HomeRouterProtocol: AnyObject {
    func navigateToArticle(with article: Article)
}

class HomeRouter: HomeRouterProtocol {
    weak var viewController = UIViewController()
    
    func navigateToArticle(with article: Article) {
        DispatchQueue.main.async {
            guard let navigationController = self.viewController?.navigationController else { return }
            let ArticleViewController = ArticleModule.build(with: article)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.pushViewController(ArticleViewController, animated: true)
        }
    }
}
