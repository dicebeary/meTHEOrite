//
//  MainCoordinator.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import UIKit
import Domain
import Resolver
import RxSwift

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    private var navigationController: UINavigationController
    private let bag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let containerVC = MainViewController()
        let contentCoordinator = ContentCoordinator(containerViewController: containerVC)
        
        navigationController.setViewControllers([containerVC], animated: true)
        contentCoordinator.start()
        
        childCoordinators.append(contentCoordinator)
        
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .automatic
    }
}
