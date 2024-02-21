//
//  AppDelegate.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 15/02/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let logInInteractor = LogInInteractor()
        let logInRouter = LogInRouter()
        let logInViewController = LogInViewController()
        let logInPresenter = LogInPresenter(view: logInViewController, interactor: logInInteractor, router: logInRouter)
        
        logInViewController.presenter = logInPresenter
        
        logInPresenter.view = logInViewController
        logInPresenter.interactor = logInInteractor
        logInPresenter.router = logInRouter
        
        logInRouter.viewController = logInViewController
        
        let navigationController = UINavigationController(rootViewController: logInViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = .black
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        return true
        
        return true
    }


    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

