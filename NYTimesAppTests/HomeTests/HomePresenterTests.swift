//
//  HomePresenterTests.swift
//  NYTimesAppTests
//
//  Created by Agostina Corcuera Di Salvo on 21/02/2024.
//

import Foundation
import XCTest
@testable import NYTimesApp

class HomePresenterTests: XCTestCase {
    
    var sut: HomePresenter!
    var mockView: MockHomeView!
    var mockInteractor: MockHomeInteractor!
    var mockRouter: MockHomeRouter!
    
    override func setUp() {
        super.setUp()
        mockView = MockHomeView()
        mockInteractor = MockHomeInteractor()
        mockRouter = MockHomeRouter()
        sut = HomePresenter()
        sut.view = mockView
        sut.interactor = mockInteractor
        sut.router = mockRouter
    }
    
    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetArticlesSuccess() {
        // Given
        let expectedArticles: [Article] = [Article(id: 1,
                                                   title: "Example",
                                                   abstract: "Example article",
                                                   published_date: "2024-02-01",
                                                   byline: "Example Author",
                                                   media: [])]
        
        mockInteractor.getArticlesClosure = { completion in
            completion(expectedArticles, nil)
        }
        
        // When
        sut.getArticles()
        
        // Then
        XCTAssertFalse(mockView.showErrorAlertCalled)
        XCTAssertFalse(mockView.changeConnectionStatusCalled)
    }
    
    func testGetArticlesFailure() {
        // Given
        mockInteractor.getArticlesClosure = { completion in
            completion(nil, NSError(domain: "Test", code: 0, userInfo: nil))
        }
        
        // When
        sut.getArticles()
        
        // Then
        XCTAssertTrue(mockView.showErrorAlertCalled)
        XCTAssertTrue(mockView.changeConnectionStatusCalled)
        XCTAssertFalse(mockView.updateTableViewWithDataCalled)
    }
    
    func testDidSelectRow() {
        // Given
        let article = Article(id: 1, title: "Example", abstract: "Example article",
                              published_date: "2024-02-01", byline: "Example Author", media: [])
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        sut.didSelectRow(with: article, at: indexPath)
        
        // Then
        XCTAssertTrue(mockRouter.navigateToArticleCalled)
        XCTAssertEqual(mockRouter.navigateToArticleArticle, article)
    }
}

// MARK: - Mock Classes

class MockHomeView: HomeViewProtocol {
    var presenter: HomePresenterProtocol = HomePresenter()
    var updateTableViewWithDataCalled = false
    var updateTableViewWithDataArticles: [Article]?
    var showErrorAlertCalled = false
    var changeConnectionStatusCalled = false
    
    func updateTableView(withData data: [Article]) {
        updateTableViewWithDataCalled = true
        updateTableViewWithDataArticles = data
    }
    
    func showErrorAlert(type: AlertType) {
        showErrorAlertCalled = true
    }
    
    func changeConectionStatus() {
        changeConnectionStatusCalled = true
    }
}

class MockHomeInteractor: HomeInteractorProtocol {
    var getArticlesClosure: ((@escaping ([Article]?, Error?) -> Void) -> Void)?
    
    func getArticles(completion: @escaping ([Article]?, Error?) -> Void) {
        getArticlesClosure?(completion)
    }
}

class MockHomeRouter: HomeRouterProtocol {
    var navigateToArticleCalled = false
    var navigateToArticleArticle: Article?
    
    func navigateToArticle(with article: Article) {
        navigateToArticleCalled = true
        navigateToArticleArticle = article
    }
}

