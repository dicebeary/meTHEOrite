//
//  MainCoordinator.swift
//  Placeboop
//
//  Created by Vajda Kristóf on 2021. 08. 29..
//

import UIKit

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let containerVC = MainViewController()
        navigationController.setViewControllers([containerVC], animated: true)
        
        let contentCoordinator = ContentCoordinator(containerViewController: containerVC)
        contentCoordinator.start()
        childCoordinators.append(contentCoordinator)
    }
}
