//
//  MainCoordinator.swift
//  Placeboop
//
//  Created by Vajda Kristóf on 2021. 08. 29..
//

import UIKit

final class MainCoordinator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let containerVC = UIViewController()
        navigationController.setViewControllers([containerVC], animated: true)
        
        let listCoordinator = ContentCoordinator(tabBarController: tabBarController)
        listCoordinator.start()
    }
}
