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
    
    @Injected private var meteoriteLandingInteractor: MeteoriteLandingInteractorInterface
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
        
        setupInitialData()
        setupNavigationController()
    }
    
    private func setupInitialData() {
        meteoriteLandingInteractor.getLandings()
            .subscribe()
            .disposed(by: bag)
    }
    
    private func setupNavigationController() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .automatic
    }
}
