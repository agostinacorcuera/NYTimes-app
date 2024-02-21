//
//  LogInInteractor.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 15/02/2024.
//

import Foundation

protocol LoginInteractorProtocol: AnyObject {
    func logIn(username: String, password: String, completion: @escaping (Bool) -> Void)
}

class LogInInteractor: LoginInteractorProtocol {
    
    private let usersDatabase = [
        "user1": "password1",
        "user2": "password2",
        "user3": "password3"
    ]
    
    func logIn(username: String, password: String, completion: @escaping (Bool) -> Void) {
        if let storedPassword = usersDatabase[username], storedPassword == password {
            completion(true)
        } else {
            completion(false)
        }
    }
}

