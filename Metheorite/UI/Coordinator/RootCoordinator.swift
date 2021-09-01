//
//  RootCoordinator.swift
//  Placeboop
//
//  Created by Vajda Kristóf on 2021. 08. 29..
//

import UIKit

final class RootCoordinator {
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
    }
}
