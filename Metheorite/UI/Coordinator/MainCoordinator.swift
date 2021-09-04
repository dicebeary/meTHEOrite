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
        navigationController.setViewControllers([containerVC], animated: true)
        
        let contentCoordinator = ContentCoordinator(containerViewController: containerVC)
        contentCoordinator.start()
        childCoordinators.append(contentCoordinator)
        
        setupInitialData()
    }
    
    private func setupInitialData() {
        meteoriteLandingInteractor.getLandings()
            .subscribe()
            .disposed(by: bag)
    }
}
