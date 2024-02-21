//
//  HomePresenter.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 15/02/2024.
//

import Foundation
import UIKit

protocol HomePresenterProtocol: AnyObject {
    func getArticles()
    func didSelectRow(with article: Article, at indexPath: IndexPath)
    func showErrorAlert()
}

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    private var articles: [Article] = []
    
    func getArticles() {
        interactor?.getArticles { [weak self] (articles, error) in
                if let error = error {
                    self?.showErrorAlert()
                    return
                }
                
                if let articles = articles {
                    self?.reloadTableView(with: articles)
                }
            }
    }
    
    func reloadTableView(with articles: [Article]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateTableView(withData: articles)
        }
    }
    
    func showErrorAlert() {
        view?.showErrorAlert(type: AlertType.noInternetConection)
        view?.changeConectionStatus()
    }
    
    func didSelectRow(with article: Article, at indexPath: IndexPath) {
        router?.navigateToArticle(with: article)
    }

}
