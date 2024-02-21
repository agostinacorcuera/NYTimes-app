//
//  NavBarManager.swift
//  NYTimesApp
//
//  Created by Agostina Corcuera Di Salvo on 20/02/2024.
//

import Foundation
import UIKit

class NavBarManager {
    static let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 5)
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    static func setupNavigationBar() -> UIView {
        let titleContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
            titleContainerView.addSubview(logoImageView)
        
        let padding: CGFloat = 5
            logoImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                logoImageView.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: padding),
                logoImageView.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: padding),
                logoImageView.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -padding),
                logoImageView.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: -padding)
            ])
        
        return titleContainerView
    }
}
