//
//  HomeViewController.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 15/02/2024.
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol { get set }
    func updateTableView(withData data: [Article])
    func showErrorAlert(type: AlertType)
    func changeConectionStatus()
}

class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol
    private var articles: [Article] = []
    private var isConected: Bool = true
    
    var savedArticles: [Article] = {
        return DataManager.loadSavedArticles()
    }()
  
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchData()
        setupScrollView()
        setupTableView()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    
    private func setupNavigationBar() {
        self.navigationItem.titleView = NavBarManager.setupNavigationBar()
        navigationController?.navigationBar.isHidden = false
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        scrollView.addSubview(tableView)
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        tableView.backgroundColor = .white
        tableView.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        tableView.register(HomeCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func fetchData() {
        presenter.getArticles()
    }
    
    func changeConectionStatus() {
        isConected = false
    }
    
    func updateTableView(withData data: [Article]) {
        DispatchQueue.main.async {
            self.articles = data
            self.tableView.reloadData()
        }
    }
    
    func showErrorAlert(type: AlertType) {
        DispatchQueue.main.async {
            AlertManager.showAlert(type: type, in: self)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isConected ? articles.count : savedArticles.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeCell
        
        if isConected {
            let article = articles[indexPath.row]
            cell.configure(with: article)
        } else {
            let savedArticle = savedArticles[indexPath.row]
            cell.configure(with: savedArticle)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
        cell.addGestureRecognizer(tapGesture)
        cell.tag = indexPath.row
        
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        return cell
    }
    
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? UITableViewCell else { return }
        let indexPath = IndexPath(row: cell.tag, section: 0)
        tableView(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = isConected ? articles[indexPath.row] : savedArticles[indexPath.row]
            presenter.didSelectRow(with: article, at: indexPath)
        
        if isConected {
            DispatchQueue.main.async {
                var articles = self.savedArticles
                articles.append(article)
                DataManager.saveArticles(articles)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let article = isConected ? articles[indexPath.row] : savedArticles[indexPath.row]
        guard let title = article.title else { return 0 }
        guard let date = article.published_date else { return 0 }
        
        let titleHeight = heightForLabel(text: title, font: UIFont.boldSystemFont(ofSize: 25), width: tableView.frame.width - 40)
        let dateHeight = heightForLabel(text: date, font: UIFont.systemFont(ofSize: 10), width: tableView.frame.width - 40)
        
        return titleHeight + dateHeight + 40
    }
    
    private func heightForLabel(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
}

