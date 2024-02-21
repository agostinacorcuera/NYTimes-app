//
//  AlertManager.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 20/02/2024.
//

import Foundation
import UIKit

import Foundation
import UIKit

class AlertManager {
    
    static func showAlert(type: AlertType, in viewController: UIViewController) {
        let alertController = UIAlertController(title: title(for: type), message: message(for: type), preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }

    static func title(for type: AlertType) -> String {
        switch type {
            case .genericError:
                return "¡Ups!"
            case .emptyFields:
                return ""
            case .authenticationFailed:
                return "Credentials error"
            case .noInternetConection:
                return "No internet conection"
        }
    }

    static func message(for type: AlertType) -> String {
        switch type {
            case .genericError:
                return "An error has occurred. Please try again."
            case .emptyFields:
                return "Fields can not be empty."
            case .authenticationFailed:
                return "Incorrect username or password."
            case .noInternetConection:
                return "You can only read saved articles."
        }
    }

}

enum AlertType {
    case genericError
    case emptyFields
    case authenticationFailed
    case noInternetConection
}

