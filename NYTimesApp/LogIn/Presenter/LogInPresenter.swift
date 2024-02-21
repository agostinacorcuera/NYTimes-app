//
//  LogInPresenter.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 15/02/2024.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func loginButtonPressed(username: String, password: String)
    func loginDidSucceed()
    func loginDidFail()
}

class LogInPresenter: LoginPresenterProtocol {
    weak var view: LogInViewController?
    var interactor: LogInInteractor
    var router: LogInRouter
    
    init(view: LogInViewController, interactor: LogInInteractor, router: LogInRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
        
        func loginButtonPressed(username: String, password: String) {
            interactor.logIn(username: username, password: password) { success in
                if success {
                    self.loginDidSucceed()
                } else {
                    self.loginDidFail()
                }
            }
        }
        
        func loginDidSucceed() {
            router.navigateToHome()
        }
        
    func loginDidFail() {
        view?.showErrorAlert(type: AlertType.authenticationFailed)
    }
}
