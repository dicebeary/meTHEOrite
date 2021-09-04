//
//  RootCoordinator.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import UIKit

final class RootCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navVC = UINavigationController()

        window.rootViewController = navVC
        window.makeKeyAndVisible()
        
        let mainCoordinator = MainCoordinator(navigationController: navVC)
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
    }
}
