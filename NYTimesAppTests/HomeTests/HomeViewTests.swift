//
//  HomeTests.swift
//  NYTimesAppTests
//
//  Created by Agostina Corcuera Di Salvo on 20/02/2024.
//

import Foundation
import XCTest
@testable import NYTimesApp

final class HomeViewTests: XCTestCase {
    
    var sut: HomeViewController!
    var mockPresenter: MockHomePresenter!
    
    override func setUpWithError() throws {
        mockPresenter = MockHomePresenter()
        sut = HomeViewController(presenter: mockPresenter)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockPresenter = nil
    }

    func testViewDidLoad() throws {
        sut.viewDidLoad()
        
        XCTAssertTrue(mockPresenter.fetchDataCalled)
    }
}

    // MARK: - Mock Classes

class MockHomePresenter: HomePresenterProtocol {
    var view: HomeViewProtocol?
    var interactor: HomeInteractor?
    var router: HomeRouterProtocol?
    var fetchDataCalled = false

    func getArticles() {
        fetchDataCalled = true
    }

    func reloadTableView(with articles: [Article]) {}
    func showErrorAlert() {}
    func didSelectRow(with article: Article, at indexPath: IndexPath) {}
}
