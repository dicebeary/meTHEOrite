//
//  ContentCoordinator.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import UIKit
import RxSwift

final class ContentCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    private var listScreen: ListViewController!
    private var mapScreen: MapViewController!

    private var containerViewController: MainViewController
    let bag = DisposeBag()
    
    init(containerViewController: MainViewController) {
        self.containerViewController = containerViewController
        self.containerViewController.screenDelegate = self
    }
    
    func start() {
        listScreen = ListViewController()
        mapScreen = MapViewController()
        containerViewController.add(child: listScreen)
        containerViewController.add(child: mapScreen)
        containerViewController.title = Localization.listTitle
        mapScreen.view.isHidden = true
    }
}

// MARK: - MainScreenDelegate
extension ContentCoordinator: MainScreenDelegate {
    func segmentDidChange(index: Int) {
        switch index {
        case 0:
            listScreen.view.isHidden = false
            mapScreen.view.isHidden = true
        case 1:
            listScreen.view.isHidden = true
            mapScreen.view.isHidden = false
        default:
            break
        }
    }

    func sortButtonTapped() {
        print("sort")
    }
}
