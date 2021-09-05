//
//  ContentCoordinator.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import UIKit
import RxSwift
import Domain
import Resolver

final class ContentCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    @Injected private var interactor: MeteoriteLandingInteractorInterface
    
    private var listScreen: ListViewController!
    private var mapScreen: MapViewController!

    private var containerViewController: MainViewController
    let bag = DisposeBag()
    
    init(containerViewController: MainViewController) {
        self.containerViewController = containerViewController
        super.init()

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

// MARK: - MainScreenDelegate, PopoverControllerDelegate
extension ContentCoordinator: MainScreenDelegate, UIPopoverPresentationControllerDelegate {
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

    func sortButtonTapped(sender: UIBarButtonItem) {
        let popoverScreen = SortPopoverViewController()
        popoverScreen.screenDelegate = self
        popoverScreen.modalPresentationStyle = .popover

        let popover = popoverScreen.popoverPresentationController
        popover?.barButtonItem = sender
        popoverScreen.preferredContentSize = CGSize(width: 120, height: 220)
        popover?.delegate = self
        popover?.sourceView = sender.customView
        popover?.sourceRect = sender.customView?.bounds ?? CGRect()
        
        containerViewController.present(popoverScreen, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}

// MARK: - SortPopoverScreenDelegate
extension ContentCoordinator: SortPopoverScreenDelegate {
    func itemSelected(viewController: UIViewController, at indexPath: IndexPath) {
        interactor.sortingTypes
            .take(1)
            .map { $0[indexPath.row] }
            .flatMap { [weak self] attribute -> Completable in
                guard let self = self else { return .empty() }
                return self.interactor.sortMeteorite(by: attribute)
            }
            .subscribe(onCompleted: {
                viewController.dismiss(animated: true, completion: nil)
            })
            .disposed(by: bag)

    }
}
