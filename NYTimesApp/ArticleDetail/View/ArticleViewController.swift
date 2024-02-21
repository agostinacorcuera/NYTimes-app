//
//  ArticleViewController.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 19/02/2024.
//

import Foundation
import UIKit

protocol ArticleViewProtocol: AnyObject {
    func showGenericErrorAlert()
}

class ArticleViewController: UIViewController, ArticleViewProtocol {
    var article: Article
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentStack: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .vertical
         stackView.spacing = 12
         stackView.distribution = .fill
         stackView.translatesAutoresizingMaskIntoConstraints = false
         return stackView
     }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let abstractLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let publishedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 13)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        customizeView()
        customizeConstraints()
        fetchData()
    }
    
    private func customizeView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(abstractLabel)
        contentStack.addArrangedSubview(authorLabel)
        contentStack.addArrangedSubview(publishedDateLabel)
    }

    private func setupNavigationBar() {
        self.navigationItem.titleView = NavBarManager.setupNavigationBar()
        navigationController?.navigationBar.isHidden = false
    }
    
    private func customizeConstraints() {
           NSLayoutConstraint.activate([
               scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
               contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
               contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
               contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
               contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
               titleLabel.topAnchor.constraint(equalTo: contentStack.topAnchor, constant: 20),
               titleLabel.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 20),
               titleLabel.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -25),
               abstractLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
               abstractLabel.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 20),
               abstractLabel.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -20),
               authorLabel.topAnchor.constraint(equalTo: abstractLabel.bottomAnchor, constant: 35),
               authorLabel.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -20),
               authorLabel.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 20),
               publishedDateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
               publishedDateLabel.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor, constant: -20),
               publishedDateLabel.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 20)
           ])
       }
    
    func fetchData() {
        DispatchQueue.main.async {
            self.titleLabel.text = self.article.title
            self.abstractLabel.text = self.article.abstract
            self.publishedDateLabel.text = self.article.published_date
            self.authorLabel.text = self.article.byline
        }
    }
    
    func showGenericErrorAlert() {
        DispatchQueue.main.async {
            AlertManager.showAlert(type: .genericError, in: self)
        }
    }

}
