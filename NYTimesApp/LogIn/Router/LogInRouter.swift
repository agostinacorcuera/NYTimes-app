//
//  LogInRouter.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 15/02/2024.
//

import Foundation
import UIKit

protocol LoginRouterProtocol: AnyObject {
    func navigateToHome()
}

class LogInRouter: LoginRouterProtocol {
    var viewController: UIViewController?
    
    func navigateToHome() {
        DispatchQueue.main.async {
            guard let navigationController = self.viewController?.navigationController else { return }
            let homeViewController = HomeModule.build()
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.pushViewController(homeViewController, animated: true)
        }
    }
}
