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

    private var containerViewController: UIViewController
    let bag = DisposeBag()
    
    init(containerViewController: UIViewController) {
        self.containerViewController = containerViewController
    }
    
    func start() {
        setupSegmentedControl()
        setupNavigationBarButtons()
        
        listScreen = ListViewController()
        mapScreen = MapViewController()
        add(child: listScreen, to: containerViewController)
        add(child: mapScreen, to: containerViewController)
        containerViewController.title = Localization.listTitle
        mapScreen.view.isHidden = true
    }
    
    private func setupSegmentedControl() {
        let segmentedControl = UISegmentedControl(items: [Localization.listTitle, Localization.mapTitle])
        segmentedControl.frame.size = CGSize(width: 240, height: 30)
        segmentedControl.selectedSegmentIndex = 0
        containerViewController.navigationItem.titleView = segmentedControl

        segmentedControl.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
    }
    
    private func setupNavigationBarButtons() {
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: nil)
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: nil)
        containerViewController.navigationItem.leftBarButtonItem = sortButton
        containerViewController.navigationItem.rightBarButtonItem = refreshButton

    }

    private func add(child viewController: UIViewController, to parent: UIViewController) {
        // Add Child View Controller
        parent.addChild(viewController)
        
        // Add Child View as Subview
        parent.view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = parent.view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: parent)
    }
    
    private func remove(child viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    @objc private func segmentDidChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            containerViewController.title = Localization.listTitle
            listScreen.view.isHidden = false
            mapScreen.view.isHidden = true
        } else {
            containerViewController.title = Localization.mapTitle
            listScreen.view.isHidden = true
            mapScreen.view.isHidden = false
        }
    }
}
