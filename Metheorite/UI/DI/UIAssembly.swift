//
//  UIAssembly.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 17..
//

import Swinject
import SwinjectStoryboard
import Domain

public final class UIAssembly: Assembly {
    public init() { /* no-op */ }

    public func assemble(container: Container) {
        registerList(to: container)
        registerDetails(to: container)
    }
}

// MARK: - List
private extension UIAssembly {
    func registerList(to container: Container) {
        container.register(ListViewModel.self) { resolver in
            ListViewModel(newsInteractor: resolver.resolve(NewsInteractorInterface.self)!)
        }

        container.storyboardInitCompleted(ListViewController.self) { resolver, screen in
            screen.viewModel = resolver.resolve(ListViewModel.self)!
        }
    }
}

// MARK: - Details
private extension UIAssembly {
    func registerDetails(to container: Container) {
//        container.register(DetailsViewModel.self) { resolver in
//            DetailsViewModel(newsInteractor: resolver.resolve(NewsInteractorInterface.self)!)
//        }
//
//        container.storyboardInitCompleted(DetailsViewController.self) { resolver, screen in
//            screen.viewModel = resolver.resolve(DetailsViewModel.self)!
//        }
    }
}
