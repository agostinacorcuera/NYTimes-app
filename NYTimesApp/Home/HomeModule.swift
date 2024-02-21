//
//  HomeModule.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 16/02/2024.
//

import Foundation
import UIKit

class HomeModule {
    static func build() -> UIViewController {
        
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter()
        let view = HomeViewController(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        view.presenter = presenter
                
        router.viewController = view
        
        return view
    }
}
